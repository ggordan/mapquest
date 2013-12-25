require 'rest-client'
require 'json'
require "mapquest/response"
require "mapquest/request"
require "mapquest/services/core"
require "mapquest/services/directions"
require "mapquest/services/geocoding"

class MapQuest

  attr_accessor :api_key, :version

  def initialize(key, version=1)
    @api_key = key
    @version = version
  end

  # Acess the geocoding API
  def geocoding
    Services::Geocoding.new self
  end

  # Access the directions API
  def directions
    Services::Directions.new self
  end

  # Request handler for the web services. Creates a new request based on the API method provided, and returns a new
  # response object. Removes any empty parameters that were provided. This method is only used internally.
  # ==Required parameters
  # * method [Hash] The hash containing the API method, version and type.
  # * params [Hash] The parameters used for creating the query string
  # * response [Response] The response object of the API being called
  def request(method, params, response)
    req = Request.new method
    params.merge! :key => api_key
    params.each { |k,v| params.delete(k) if v.nil? }
    response.new req.query(params), params
  end

end
