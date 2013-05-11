require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'MapQuest::Services::Geocoding' do

  context 'when valid request' do

    before :all do
      @mapquest = MapQuest.new 'xxx'
      @response = MapQuest::Services::Geocoding::Response.new fixture 'results'
      @response.valid.should == true
    end

    describe '.new' do
      it 'should be an instance of' do
        @mapquest.geocoding.should be_an_instance_of MapQuest::Services::Geocoding
      end
    end

    describe '#decode' do
      it 'should raise an error' do
        expect { @mapquest.geocoding.decode }.to raise_error
      end
      it 'should be an instance of' do
        @response.should be_an_instance_of MapQuest::Services::Geocoding::Response
      end
    end

    describe '#Request' do
      it 'should return 0' do
        @response.status[:code].should == 0
      end
      it 'should be empty' do
        @response.status[:messages].should == []
      end
      it 'should return locations' do
        @response.locations.should_not == {}
      end
    end

  end

  context 'when invalid request' do

    before :all do
      @mapquest = MapQuest.new 'xxx'
      @response = @mapquest.geocoding.decode :location => "London, UK"
      @response.valid.should == false
    end

    describe '.new' do
      it 'should be an instance of' do
        @mapquest.geocoding.should be_an_instance_of MapQuest::Services::Geocoding
      end
    end

    describe '#decode' do
      it 'should raise an error' do
        expect { @mapquest.geocoding.decode }.to raise_error
      end
      it 'should be an instance of' do
        @response.should be_an_instance_of MapQuest::Services::Geocoding::Response
      end
    end

    describe '#Request' do
      it 'should not return 0' do
        @response.status[:code].should_not == 0
      end
      it 'should not be empty' do
        @response.status[:messages].should_not == []
      end
      it 'should not return 0' do
        @response.locations[:code].should_not == 0
      end
    end

  end
end