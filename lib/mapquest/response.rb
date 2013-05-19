class MapQuest
  class Response

    attr_reader :response, :valid, :params

    class InvalidRequest < StandardError; end

    def initialize(response_string, params = {})
      @params = params
      @response = JSON.parse(response_string, :symbolize_names => true)
      valid_request?
    end

    # Check whether the request made to the API call is valid. Raises an error if the response code is 500
    def valid_request?
      # 400 - Error with input
      # 403 - Key related error
      # 500 -Unknown error
      # Check http://www.mapquestapi.com/geocoding/status_codes.html for more details
      @valid = case status[:code]
        when 500
          raise InvalidRequest
        when 400, 403
          false
        else
          true
      end
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