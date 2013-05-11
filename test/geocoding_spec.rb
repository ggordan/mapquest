require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MapQuest::Services::Geocoding" do

  before :all do
    init
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
      response = @mapquest.geocoding.decode :location => "London, UK"
      response.should be_an_instance_of MapQuest::Response
    end

  end

  describe '#response' do
  end

end