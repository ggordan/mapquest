class MapQuest
  class Response

    attr_reader :response, :valid, :params

    class InvalidRequest < StandardError; end

    def initialize(response_string, params = {})
      @params = params
      @response = JSON.parse(response_string, :symbolize_names => true)
    end

    def info
      response[:info]
    end

    def copyright
      info[:copyright]
    end

    def options
      response[:options]
    end

    # Returns information about the response.
    # :code is an integer return value. See http://www.mapquestapi.com/geocoding/status_codes.html
    # :messages subfield is an array of error messages which describe the status.
    def status
      return :code => info[:statuscode].to_i, :messages => info[:messages]
    end

  end
end