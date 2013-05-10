require 'mapquest_geolocation'

RSpec.configure do |config|

  def fixture(filename)
    File.dirname(__FILE__) + '/fixtures/' + filename + '.json'
  end

  def init
    @mapquest_geocode = MapQuestGeocode.new 'xxx'
  end

end