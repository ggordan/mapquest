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

  describe '#decode' do
      context 'and :location is provided' do
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
      context 'and :location and :maxResults are provided' do
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
  end

  describe '#reverse' do
    context ':location is provided' do
      it 'should receive a :location array' do
        mapquest.stub_chain(:geocoding, :reverse)
        mapquest.geocoding.should_receive(:reverse).with(:location => ['xxx','xxx'])
        mapquest.geocoding.reverse(:location => ['xxx','xxx'])
      end
      it 'should raise an error if :location is not an array' do
        expect { mapquest.geocoding.reverse :location => 'xxx' }.to raise_error(MapQuest::Error)
      end
      it 'should return an instance of Geocoding::Response' do
        response = mapquest.geocoding.reverse :location => ['xxx','xxx']
        response.should be_an_instance_of MapQuest::Services::Geocoding::Response
      end
    end
    context 'and :maxResults are provided' do
      it 'should receive :location and :maxResults' do
        mapquest.stub_chain(:geocoding, :reverse)
        mapquest.geocoding.should_receive(:reverse).with(:location => ['xxx', 'xxx'], :maxResults => 3)
        mapquest.geocoding.reverse(:location => ['xxx', 'xxx'], :maxResults => 3)
      end
      it 'should raise an error if :location is omitted' do
        expect { mapquest.geocoding.reverse :maxResults => 3 }.to raise_error(MapQuest::Error)
      end
      it 'should raise an error if :location is not an array' do
        expect { mapquest.geocoding.reverse :location => 'xxx',:maxResults => 3 }.to raise_error(MapQuest::Error)
      end
      it 'should return an instance of Geocoding::Response' do
        response = mapquest.geocoding.reverse :location => ['xxx', 'xxx'], :maxResults => 3
        response.should be_an_instance_of MapQuest::Services::Geocoding::Response
      end
    end
  end

  context 'when request is valid' do
    describe MapQuest::Services::Geocoding::Response do

      let(:max_results) { -1 }
      let(:fixt) { 'geocoding/valid_results' }
      let(:thumb_maps) { true }

      let(:valid_response) do
        params = {
            :location => 'London, UK',
            :maxResults => max_results,
            :thumbMaps => thumb_maps
        }
        MapQuest::Services::Geocoding::Response.new fixture(fixt), params
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

      context 'only :location is provided' do
        it 'should return the provided location' do
          valid_response.providedLocation[:location].should == valid_response.params[:location]
        end
      end
      context ':maxResults is also provided' do
        let(:max_results) { 2 }
        let(:fixt) { 'geocoding/with_maxResults' }
        it 'maxResults option should equal to provided max results' do
          valid_response.options[:maxResults].should == valid_response.params[:maxResults]
        end
        it 'should return equal to or less than max amount of locations' do
          number_of_results = valid_response.locations.length
          valid_response.params[:maxResults].should >= number_of_results
        end
      end
      context ':thumbMap is also provided' do
        let(:fixt) { 'geocoding/with_thumbMaps' }
        let(:thumb_maps) { false }
        it 'maxResults option should equal to provided max results' do
          valid_response.options[:thumbMaps].should == valid_response.params[:thumbMaps]
        end
      end
      context ':thumbMap is also provided' do
        let(:fixt) { 'geocoding/with_thumbMaps_and_maxResults' }
        let(:thumb_maps) { false }
        let(:max_results) { 2 }
        it 'maxResults option should equal to provided max results' do
          valid_response.options[:thumbMaps].should == valid_response.params[:thumbMaps]
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