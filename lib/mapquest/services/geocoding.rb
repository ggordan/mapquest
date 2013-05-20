class MapQuest
  module Services
    # The main class used for communicating with the MapQuest Geocoding API
    class Geocoding < Core

      API_LOCATION = :geocoding
      VALID_OPTIONS = [:location,:maxResults,:thumbMaps]

      class TooManyLocations < StandardError; end

      # Allows you to search for a single location and returns a response object of the found locations
      #
      #   Example: .address :location => "London, UK"
      #
      # ==Required parameters
      # * location [String] The location for which you wish to get data
      # ==Optional parameters
      # * :maxResults [Integer] The number of results to limit the response to. Defaults to -1 (-1 indicates no limit)
      # * :thumbMaps [Boolean] Return a URL to a static map thumbnail image for a location. Defaults to true
      def address(location, options = {})
        raise ArgumentError, 'Method must receive a location (string)' unless location
        options[:location] = location
        call_api self, 1, 'address', options
      end

      # Allows you to search for a location using lat/lng values and returns a response object of the found locations
      #
      #   Example: .reverse :location => ['40.0755','-76.329999']
      #
      # ==Required parameters
      # * location [Array] The lat, and lng to search for
      # ==Optional parameters
      # * :maxResults [Integer] The number of results to limit the response to. Defaults to -1 (-1 indicates no limit)
      # * :thumbMaps [Boolean] Return a URL to a static map thumbnail image for a location. Defaults to true
      def reverse(location, options = {})
        raise ArgumentError, 'Method must receive a location (array)' unless location && location.kind_of?(Array)
        options[:location] = location.join(',')
        call_api self, 1, 'reverse', options
      end


      class Response < MapQuest::Response

        def initialize(response_string, params = {})
          super
        end

        def locations
          if valid
            response[:results].first[:locations]
          end
        end

        def providedLocation
          if valid
            response[:results].first[:providedLocation]
          end
        end

      end

    end
  end
end