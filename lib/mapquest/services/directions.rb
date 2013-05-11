class MapQuest
  module Services
    class Directions < Core

      API_LOCATION = :directions

      def get(params)
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

        def valid_request?
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