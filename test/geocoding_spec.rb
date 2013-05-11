require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MapQuest::Services::Geocoding" do

  before :all do
    init
    @response = @mapquest.geocoding.decode :location => "London, UK"
  end

  describe '.new' do

    it 'should be an instance of MapQuest::Service::Geocoding' do
      @mapquest.geocoding.should be_an_instance_of MapQuest::Services::Geocoding
    end

  end

  describe '#decode' do

    it 'should raise an error if :location was not specified' do
      expect { @mapquest.geocoding.decode }.to raise_error
    end

    it 'should return a new response object if :location was specified' do
      @response.should be_an_instance_of MapQuest::Services::Geocoding::Response
    end

  end

  describe "Response" do
    it 'should return 403 if the key is invalid' do
      @response.status[:code].should == 403
    end

    it 'should return error messages if the status code is not 0' do
      @response.status[:code].should_not == 0
      @response.status[:messages].should_not be_empty
    end

    it 'should return empty results if the status code is not 0' do
      @response.status[:code].should_not == 0
      @response.locations.should be_empty
      @response.providedLocation.should be_empty
    end

  end

end