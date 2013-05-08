require 'rest-client'
require 'json'
require "mapquest_geolocation/version"
require "mapquest_geolocation/request"
require "mapquest_geolocation/response"

class MapQuestGeocode

  attr_accessor :api_key

  class Error < StandardError; end

  def initialize(key)
    @api_key = key
  end

  def decode(params = {})
    unless params.has_key? :location
      raise Error
    end
    request params
  end

  def request(params)
    req = MapquestGeolocation::Request.new
    params.merge! :key => api_key
    params.each { |k,v| params.delete(k) if v.nil? }

    response = MapquestGeolocation::Response.new req.send(params)
    response
  end

end
