require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MapQuest do

  let(:mapquest) do
   MapQuest.new('xxx')
  end

  describe '.new' do

    it 'should raise error if key is missing' do
      expect { MapQuest.new }.to raise_error(ArgumentError)
    end

    it 'should be instantiated' do
      mapquest.should be_an_instance_of MapQuest
    end

    it 'should have an api key' do
      mapquest.api_key.should_not == nil
    end

  end

  let(:mapquest) do
    MapQuest.new('xxx')
  end

  describe '#geocoding' do

    it 'should instantiate Geocoding' do
      MapQuest::Services::Geocoding.should_receive(:new)
      mapquest.geocoding
    end

    it 'should raise an error if argument is passed' do
      expect { mapquest.geocoding("xxx") }.to raise_error(ArgumentError)
    end

  end

  describe '#directions' do

    it 'should instantiate Directions' do
      MapQuest::Services::Directions.should_receive(:new)
      mapquest.directions
    end

    it 'should raise an error if argument is passed' do
      expect { mapquest.directions("xxx") }.to raise_error(ArgumentError)
    end

  end


end