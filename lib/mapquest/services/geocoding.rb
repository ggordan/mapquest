class MapQuest
  module Services
    class Geocoding < Core

      API_LOCATION = :geocoding

      class TooManyLocations < StandardError; end

      # Allows you to search for a single location and returns a response object of the found locations
      #
      #   Example: .decode :location => "London, UK"
      #
      # ==Required parameters
      # * :location [String] The location for which you wish to get data
      # ==Optional parameters
      # * :maxResults [Integer] The number of results to limit the response to. Defaults to -1 (-1 indicates no limit)
      # * :thumbMaps [Boolean] Return a URL to a static map thumbnail image for a location. Defaults to true
      def decode(params = {})
        raise Error unless params.has_key? :location
        remove_unavailable_params! params
        api_method = {
            :location => API_LOCATION,
            :version => '1',
            :call => 'address'
        }
        mapquest.request api_method, params, Response
      end

      # Allows you to search for a location using lat/lng values and returns a response object of the found locations
      #
      #   Example: .reverse :location => ['40.0755','-76.329999']
      #
      # ==Required parameters
      # * :location [Array] The lat, and lng to search for
      # ==Optional parameters
      # * :maxResults [Integer] The number of results to limit the response to. Defaults to -1 (-1 indicates no limit)
      # * :thumbMaps [Boolean] Return a URL to a static map thumbnail image for a location. Defaults to true
      def reverse(params = {})
        raise Error unless params.has_key?(:location) && params[:location].kind_of?(Array)
        params[:location] = params[:locations].join(',')
        remove_unavailable_params! params
        api_method = {
            :location => API_LOCATION,
            :version => '1',
            :call => 'reverse'
        }
        mapquest.request api_method, params, Response
      end

      private
      def remove_unavailable_params!(params)
        params.keys.each { |k| params.delete(k) unless [:location,:maxResults,:thumbMaps].include? k }
      end

      class Response < MapQuest::Response

        def initialize(response_string, params = {})
          super response_string, params
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

      end

    end
  end
end