require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MapQuest::Services::Directions" do

  let(:mapquest) do
    MapQuest.new 'xxx'
  end

  describe '.new' do
    it 'should be an instance of' do
      mapquest.directions.should be_an_instance_of MapQuest::Services::Directions
    end
  end

  context 'when the request is valid' do

    let(:mapquest) do
      MapQuest.new 'xxx'
    end

    describe '#get' do
      it 'raise an error if :from and :to are missing' do
        expect { mapquest.directions.get }.to raise_error
      end
    end

  end

end