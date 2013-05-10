require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MapQuestGeocode" do

  before :all do
    init
  end

  describe '.new' do
    it 'should instantiate' do
      @mapquest_geocode.should be_an_instance_of MapQuestGeocode
    end
  end

  describe '#decode' do
    it 'should raise an error if :location was not specified' do
      expect { @mapquest_geocode.decode }.to raise_error
    end
    it 'should return a new response object if :location was specified' do
      response = @mapquest_geocode.decode :location => "xxx"
      response.should be_an_instance_of MapquestGeolocation::Response
    end
  end
end