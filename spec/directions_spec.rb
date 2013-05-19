require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MapQuest::Services::Directions do

  let(:mapquest) { MapQuest.new 'xxx' }

  describe '#route' do
    it 'should be an instance of Directions' do
      mapquest.directions.should be_an_instance_of MapQuest::Services::Directions
    end
  end

  describe '#route' do

    context 'to or from are not provided' do
      it 'should raise an error if location is not provided' do
        expect { mapquest.directions.route 'xxx' }.to raise_error ArgumentError
      end
    end

    context 'to and from are provided' do
      subject(:directions) { mapquest.directions.route 'Lancaster,PA', 'York,PA' }

      it 'should receive to and from' do
        fixture = fixture 'directions/route_only'
        query = {
            :key => 'xxx',
            :from => 'Lancaster,PA',
            :to => 'York,PA'
        }
        stub_request(:get, 'www.mapquestapi.com/directions/v1/route').with(:query => query).to_return(:body => fixture)
      end
    end

    context 'when request is valid' do

      describe MapQuest::Services::Directions::Response do

        let(:max_results) { -1 }
        let(:fixt) { 'directions/route_only' }
        let(:thumb_maps) { true }

        let(:valid_response) do
          query = {
              :key => 'xxx',
              :from => 'Lancaster,PA',
              :to => 'York,PA'
          }
          MapQuest::Services::Directions::Response.new fixture(fixt), query
        end

        it { valid_response.status[:code].should == 0 }
        it { valid_response.status[:messages].should == [] }
        it { valid_response.valid.should == true }
        it { valid_response.locations.should be_kind_of(Array) }
        it { valid_response.maneuvers.should be_kind_of(Array) }
        it { valid_response.distance.should be_kind_of(Integer) }
        it { valid_response.time.should be_kind_of(Integer) }
        it { valid_response.route.should be_kind_of(Hash) }

      end
    end

    context 'when invalid request' do

      context 'when api key is invalid' do
        let(:wrong_api_key_response) do
          MapQuest::Services::Directions::Response.new fixture 'directions/invalid_key'
        end

        describe MapQuest::Services::Geocoding::Response do
          it { wrong_api_key_response.status[:code].should == 403 }
          it { wrong_api_key_response.status[:messages].first.should match /^This is not a valid key/ }
        end
      end

      context 'when argument is invalid' do

        let(:invalid_argument) do
          MapQuest::Services::Geocoding::Response.new fixture 'directions/invalid_value'
        end

        describe MapQuest::Services::Geocoding::Response do
          it { invalid_argument.status[:code].should == 400 }
          it { invalid_argument.status[:messages].first.should match /^Error processing route/ }
        end

      end
    end

  end
end