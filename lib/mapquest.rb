require 'rest-client'
require 'json'
require "mapquest/response"
require "mapquest/request"
require "mapquest/services/core"
require "mapquest/services/geocoding"

class MapQuest

  attr_accessor :api_key, :response
  class Error < StandardError; end

  def initialize(key)
    @api_key = key
  end

  def geocoding
    Services::Geocoding.new self
  end

  def request(method, params, response)
    req = Request.new method
    params.merge! :key => api_key
    params.each { |k,v| params.delete(k) if v.nil? }
    @response = response.new req.send(params)
    return @response
  end

end
