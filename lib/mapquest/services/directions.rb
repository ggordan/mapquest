class MapQuest
  module Services
    class Directions < Core

      API_LOCATION = :directions


      # Allows you to search for a directions to a location. It returns a response object of the found locations
      #
      #   Example: .basic :to => "London, UK", "Manchester, UK"
      #
      # ==Required parameters
      # * :location [String] The location for which you wish to get data
      # ==Optional parameters
      # * :maxResults [Integer] The number of results to limit the response to. Defaults to -1 (-1 indicates no limit)
      # * :thumbMaps [Boolean] Return a URL to a static map thumbnail image for a location. Defaults to true
      def basic(params)
        if params.has_key? :from && :to
          api_method = {
              :location => API_LOCATION,
              :version => '1',
              :call => 'route'
          }
          response = mapquest.request api_method, params, Response
        else
          raise Error
        end
      end

      class Response < MapQuest::Response

        # Check whether the request made to the API call is valid. Raises an error if the response code is 500
        def valid_request?
          # 400 - Error with input
          # 403 - Key related error
          # 500 -Unknown error
          # Check http://www.mapquestapi.com/geocoding/status_codes.html for more details
        end

        def route
          response[:route]
        end

        # Returns the drive time in <b>minutes</b>
        def time
          (route[:time].to_i / 60).ceil
        end

        # Returns the calculated distance of the route in <b>miles</b>
        def distance
          route[:distance].to_i
        end

        def locations
          route[:locations]
        end

        # Returns a hash of the maneuvers in the route
        def maneuvers
          route[:legs].first[:maneuvers]
        end

        # Returns only the narratives for the route as a list
        def narrative
          narrative = []
          route[:legs].first[:maneuvers].each do |maneuver|
            narrative.push maneuver[:narrative]
          end
          narrative
        end

      end

    end
  end
end