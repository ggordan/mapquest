require 'mapquest'

RSpec.configure do |config|

  def fixture(filename)
    File.open(File.dirname(__FILE__) + '/fixtures/' + filename + '.json', 'r').read
  end

  def init
    @mapquest = MapQuest.new 'xxx'
  end

end