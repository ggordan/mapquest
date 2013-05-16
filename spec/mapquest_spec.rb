require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MapQuest do

  subject { MapQuest }

  describe '.new' do

    context "without api_key" do

      it 'should raise ArgumentError' do
        expect { subject.new }.to raise_error(ArgumentError)
      end

    end

  end

  describe "instance" do

    let(:key) { 'xxx' }
    subject(:instance) { MapQuest.new(key) }

    it { should be_an_instance_of MapQuest }

    its(:api_key)  { should == key }
    its(:response) { should == nil }

    describe '#geocoding' do
      subject(:geocoding) { instance.geocoding }

      it { should be_an_instance_of MapQuest::Services::Geocoding }
      its(:mapquest) { should == instance }

    end

    describe '#directions' do
      subject(:directions) { instance.directions }

      it { should be_an_instance_of MapQuest::Services::Directions }
      its(:mapquest) { should == instance }

    end

  end

end
