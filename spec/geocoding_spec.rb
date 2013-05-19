require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MapQuest::Services::Geocoding do

  let(:mapquest) { MapQuest.new 'xxx' }

  describe '#geocoding' do
    it 'should be an instance of Geocoding' do
      mapquest.geocoding.should be_an_instance_of MapQuest::Services::Geocoding
    end
  end

  describe '#address' do

    context 'location is not provided' do
      it 'should raise an error if location is not provided' do
        expect { mapquest.geocoding.address }.to raise_error ArgumentError
      end
    end

    context 'location is provided' do
      subject(:geocoding) { mapquest.geocoding.address 'London, UK' }

      it 'should receive a location' do
        fixture = fixture 'geocoding/location_only'
        query = {
            :key => 'xxx',
            :location => 'London, UK'
        }
        stub_request(:get, 'www.mapquestapi.com/geocoding/v1/address').with(:query => query).to_return(:body => fixture)
      end

      its(:providedLocation) { should == {:location => 'London, UK'} }
    end

    context 'location and :thumbMaps provided' do
      subject(:geocoding) { mapquest.geocoding.address 'London, UK', :thumbMaps => false }

      it 'should receive a location and thumbMaps' do
        fixture = fixture 'geocoding/location_thumbMaps'
        query = {
            :key => 'xxx',
            :location => 'London, UK',
            :thumbMaps => false
        }
        stub_request(:get, 'www.mapquestapi.com/geocoding/v1/address').with(:query => query).to_return(:body => fixture)
      end

      it { geocoding.options[:thumbMaps].should == false }
    end

    context 'location and :maxResults are provided' do
      subject(:geocoding) { mapquest.geocoding.address 'London, UK', :maxResults => 2 }

      it 'should receive a location and maxResults' do
        fixture = fixture 'geocoding/location_maxResults'
        query = {
            :key => 'xxx',
            :location => 'London, UK',
            :maxResults => 2
        }
        stub_request(:get, 'www.mapquestapi.com/geocoding/v1/address').with(:query => query).to_return(:body => fixture)
      end

      it { geocoding.options[:maxResults].should == 2 }

    end

  end

  describe '#reverse' do

    context 'location is not provided' do
      it 'should raise an error if location is not an array' do
        expect { mapquest.geocoding.reverse 'xxx' }.to raise_error ArgumentError
      end
    end

    context 'location is provided' do
      subject(:geocoding) { mapquest.geocoding.reverse ['40.0755', '-76.329999'] }

      it 'should receive a location' do
        fixture = fixture 'geocoding/reverse_location'
        query = {
            :key => 'xxx',
            :location => ['40.0755', '-76.329999'].join(',')
        }
        stub_request(:get, 'www.mapquestapi.com/geocoding/v1/reverse').with(:query => query).to_return(:body => fixture)
      end

    end


    context 'when request is valid' do

      describe MapQuest::Services::Geocoding::Response do

        let(:max_results) { -1 }
        let(:fixt) { 'geocoding/location_only' }
        let(:thumb_maps) { true }

        let(:valid_response) do
          params = {
              :location => 'London, UK',
              :maxResults => max_results,
              :thumbMaps => thumb_maps
          }
          MapQuest::Services::Geocoding::Response.new fixture(fixt), params
        end

        it { valid_response.status[:code].should == 0 }
        it { valid_response.status[:messages].should == [] }
        it { valid_response.valid.should == true }
        it { valid_response.locations.should be_kind_of(Array) }

        context 'only :location is provided' do
          it { valid_response.providedLocation[:location].should == valid_response.params[:location] }
          it { valid_response.copyright[:imageUrl].should == 'http://api.mqcdn.com/res/mqlogo.gif' }
        end

        context ':maxResults is also provided' do
          let(:fixt) { 'geocoding/location_maxResults' }
          let(:max_results) { 2 }
          it { valid_response.options[:maxResults].should == valid_response.params[:maxResults] }
          it { valid_response.params[:maxResults].should >= valid_response.locations.length }
        end

        context ':thumbMap is also provided' do
          let(:fixt) { 'geocoding/location_thumbMaps' }
          let(:thumb_maps) { false }
          it { valid_response.options[:thumbMaps].should == valid_response.params[:thumbMaps] }
        end

        context ':thumbMap is also provided' do
          let(:fixt) { 'geocoding/location_thumbMaps_maxResults' }
          let(:thumb_maps) { false }
          let(:max_results) { 2 }
          it { valid_response.options[:thumbMaps].should == valid_response.params[:thumbMaps] }
          it { valid_response.options[:maxResults].should == valid_response.params[:maxResults] }
          it { valid_response.params[:maxResults].should >= valid_response.locations.length }
        end
      end
    end

    context 'when invalid request' do

      context 'when api key is invalid' do
        let(:wrong_api_key_response) do
          MapQuest::Services::Directions::Response.new fixture 'geocoding/invalid_key'
        end

        describe MapQuest::Services::Directions::Response do
          it { wrong_api_key_response.status[:code].should == 403 }
          it { wrong_api_key_response.status[:messages].first.should match /^This is not a valid key/ }
        end
      end

      context 'when argument is invalid' do

        let(:invalid_argument) do
          MapQuest::Services::Directions::Response.new fixture 'geocoding/illegal_argument'
        end

        describe MapQuest::Services::Directions::Response do
          it { invalid_argument.status[:code].should == 400 }
          it { invalid_argument.status[:messages].first.should match /^Illegal argument/ }
        end

      end
    end
  end
end