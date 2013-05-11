class MapQuest
  module Services
    class Geocoding < Core

      API_LOCATION = :geocoding

      # Returns a response object of the found locations
      # == Required parameters
      # * :location [String] The location for which you wish to get data
      # == Optional parameters
      # * :maxResults [Integer] The number of results to limit the response to. Defaults to -1 (-1 indicates no limit)
      # * :thumbMaps [Boolean] Return a URL to a static map thumbnail image for a location. Defaults to true
      def decode(params = {})
        raise Error unless params.has_key? :location

        # Remove keys that are not supported
        params.keys.each { |k| params.delete(k) unless [:location,:maxResults,:thumbMaps].include? k }
        api_method = {
            :location => API_LOCATION,
            :version => '1',
            :call => 'address'
        }
        mapquest.request api_method, params, Response
      end

      # Returns a response object of the found locations
      # == Required parameters
      # * :location [Array] The lat, and lng to search for
      # == Optional parameters
      # * :maxResults [Integer] The number of results to limit the response to. Defaults to -1 (-1 indicates no limit)
      # * :thumbMaps [Boolean] Return a URL to a static map thumbnail image for a location. Defaults to true
      def reverse(params = {})
        raise Error unless params.has_key?(:location) && params[:location].kind_of?(Array)
        params[:location] = params[:location].join(',')
        api_method = {
            :location => API_LOCATION,
            :version => '1',
            :call => 'reverse'
        }
        mapquest.request api_method, params, Response
      end

      class Response < MapQuest::Response

        def initialize(response_string)
          super response_string
          valid_request?
        end

        # Check whether the request made to the API call is valid. Raises an error if the response code is 500
        def valid_request?
          # 400 - Error with input
          # 403 - Key related error
          # 500 -Unknown error
          # Check http://www.mapquestapi.com/geocoding/status_codes.html for more details
          invalid_requests = [400, 403, 500]
          if invalid_requests.include? status[:code]
            if status[:code] === 500
              raise InvalidRequest
            end
            @valid = false
          else
            @valid = true
          end
        end

        def locations
          if valid then response[:results].first[:locations] else status end
        end

        def providedLocation
          if valid then response[:results].first[:providedLocation] else status end
        end

        def options
          if valid then response[:options] else status end
        end

      end

    end
  end
end