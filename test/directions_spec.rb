require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MapQuest::Services::Directions" do

  before :all do
    init
  end

  describe '.new' do
    it 'should be an instance of' do
      @mapquest.directions.should be_an_instance_of MapQuest::Services::Directions
    end
  end

  describe '#get' do
    it 'raise an error if :from and :to are missing' do
      expect { @mapquest.directions.get }.to raise_error
    end
  end

end