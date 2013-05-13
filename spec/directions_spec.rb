require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MapQuest::Services::Directions do

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

    describe '#basic' do

      it 'should receive :to and :from' do
        mapquest.stub_chain(:directions, :basic)
        mapquest.directions.should_receive(:basic).with(:to => 'xxx', :from => 'xxx')
        mapquest.directions.basic(:to => 'xxx', :from => 'xxx')
      end

      it 'raise an error if :from and :to are missing' do
        expect { mapquest.directions.get {} }.to raise_error
      end

      it 'should return an instance of Directions::Response' do
        response = mapquest.directions.basic :to => 'xxx', :from => 'xxx'
        response.should be_an_instance_of MapQuest::Services::Directions::Response
      end

    end

  end

end