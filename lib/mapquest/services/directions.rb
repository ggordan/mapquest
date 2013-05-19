class MapQuest
  module Services
    class Directions < Core

      API_LOCATION = :directions
      VALID_OPTIONS = [:to, :from]

      # Allows you to search for direction to a location. It returns a response object of the route
      #
      #   Example: .basic :to => "London, UK", "Manchester, UK"
      #
      # ==Required parameters
      # * from [String] The location where to end route
      # * to [String] The location from which to start route
      def route(from, to, options = {})
        if from && to
          options[:to] = to
          options[:from] = from
          call_api self, 1, 'route', options
        else
          raise ArgumentError, 'The method must receive the to, and from parameters'
        end
      end

      class Response < MapQuest::Response

        def initialize(response_string, params = {})
          super
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
          if valid
            route[:distance].to_i
          end
        end

        def locations
          if valid
            route[:locations]
          end
        end

        # Returns a hash of the maneuvers in the route
        def maneuvers
          if valid
            route[:legs].first[:maneuvers]
          end
        end

        # Returns only the narratives for the route as a list
        def narrative
          if valid
            route[:legs].first[:maneuvers].map { |maneuver| maneuver[:narrative] }
          end
        end

      end

    end
  end
end