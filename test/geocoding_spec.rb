require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MapQuest::Services::Geocoding do

  let(:mapquest) do
    MapQuest.new 'xxx'
  end

  describe '#geocoding' do
    it 'should be an instance of Geocoding' do
      mapquest.geocoding.should be_an_instance_of MapQuest::Services::Geocoding
    end
  end

  context 'when valid request' do

    let(:mapquest) do
      MapQuest.new 'xxx'
    end

    context 'and :location is provided' do
      describe '#decode' do
        it 'should receive a :location' do
          mapquest.stub_chain(:geocoding, :decode)
          mapquest.geocoding.should_receive(:decode).with(:location => 'xxx')
          mapquest.geocoding.decode(:location => 'xxx')
        end
        it 'should raise an error if :location is omitted' do
          expect { mapquest.geocoding.decode }.to raise_error(MapQuest::Error)
        end
        it 'should return an instance of Geocoding::Response' do
          response = mapquest.geocoding.decode :location => 'xxx'
          response.should be_an_instance_of MapQuest::Services::Geocoding::Response
        end
      end

      describe MapQuest::Services::Geocoding::Response do

        let(:valid_response) do
          params = {
              :location => 'London, UK'
          }
          MapQuest::Services::Geocoding::Response.new fixture('geocoding/valid_results'), params
        end

        it 'status code should return 0' do
          valid_response.status[:code].should == 0
        end
        it 'error messages should be empty' do
          valid_response.status[:messages].should == []
        end
        it 'should be a valid response' do
          valid_response.valid.should == true
        end
        it 'should return a list of locations' do
          valid_response.locations.should be_kind_of(Array)
        end
        it 'should return the provided location' do
          valid_response.providedLocation[:location].should == valid_response.params[:location]
        end
      end
    end

    context 'and :location and :maxResults are provided' do
      describe '#decode' do
        it 'should receive :location and :maxResults' do
          mapquest.stub_chain(:geocoding, :decode)
          mapquest.geocoding.should_receive(:decode).with(:location => 'xxx', :maxResults => 3)
          mapquest.geocoding.decode(:location => 'xxx', :maxResults => 3)
        end
        it 'should raise an error if :location is omitted' do
          expect { mapquest.geocoding.decode :maxResults => 3 }.to raise_error(MapQuest::Error)
        end
        it 'should return an instance of Geocoding::Response' do
          response = mapquest.geocoding.decode :location => 'xxx', :maxResults => 3
          response.should be_an_instance_of MapQuest::Services::Geocoding::Response
        end
      end

      describe MapQuest::Services::Geocoding::Response do

        let(:valid_response) do
          params = {
              :location => 'London, UK',
              :maxResults => 2
          }
          MapQuest::Services::Geocoding::Response.new fixture('geocoding/decode_maxresults'), params
        end

        it 'status code should return 0' do
          valid_response.status[:code].should == 0
        end
        it 'error messages should be empty' do
          valid_response.status[:messages].should == []
        end
        it 'should be a valid response' do
          valid_response.valid.should == true
        end
        it 'should return a list of locations' do
          valid_response.locations.should be_kind_of(Array)
        end
        it 'should return the provided location' do
          valid_response.providedLocation[:location].should == valid_response.params[:location]
        end
        it 'maxResults option should equal to provided max results' do
          valid_response.options[:maxResults].should == valid_response.params[:maxResults]
        end
        it 'should return equal to or less than max amount of locations' do
          number_of_results = valid_response.locations.length
          valid_response.params[:maxResults].should >= number_of_results
        end
      end
    end
  end

  context 'when invalid request' do

    let(:mapquest) do
      MapQuest.new 'xxx'
    end

    describe '#decode' do
      it 'should raise an error if location was not specified' do
        expect { mapquest.geocoding.decode }.to raise_error
      end
    end

    context 'when api key is invalid' do

      let(:wrong_api_key_response) do
        MapQuest::Services::Geocoding::Response.new fixture 'geocoding/invalid_key'
      end

      describe MapQuest::Services::Geocoding::Response do
        it 'should return 403' do
          wrong_api_key_response.status[:code].should == 403
        end
        it 'error messages should not be empty' do
          wrong_api_key_response.status[:messages].first.should match /^This is not a valid key/
        end
      end

    end

    context 'when argument is invalid' do

      let(:invalid_argument) do
        MapQuest::Services::Geocoding::Response.new fixture 'geocoding/illegal_argument'
      end

      describe MapQuest::Services::Geocoding::Response do
        it 'should return 400' do
          invalid_argument.status[:code].should == 400
        end
        it 'error messages should not be empty' do
          invalid_argument.status[:messages].first.should match /^Illegal argument/
        end
      end

    end

  end
end