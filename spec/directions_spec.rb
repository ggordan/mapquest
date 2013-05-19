#require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
#
#describe MapQuest::Services::Directions do
#
#  let(:mapquest) do
#    MapQuest.new 'xxx'
#  end
#
#  describe '#address' do
#    it 'should receive to and from' do
#      mapquest.stub_chain(:directions, :address)
#      mapquest.directions.should_receive(:address).with('xxx', 'xxx')
#      mapquest.directions.address('xxx','xxx')
#    end
#    it 'raise an error if to or from are missing' do
#      expect { mapquest.directions.address 'xxx' }.to raise_error(ArgumentError)
#    end
#    it 'should return an instance of Directions::Response' do
#      response = mapquest.directions.address 'xxx', 'xxx'
#      response.should be_an_instance_of MapQuest::Services::Directions::Response
#    end
#  end
#
#end