class MapQuest
  module Services
    class Geocoding < Core

      def decode(params)
        raise Error unless params.has_key? :location
        response = mapquest.request :geocoding, params, Response
      end

      class Response < MapQuest::Response

        def empty?
          true if response[:results].first[:locations].any? else false
        end

        def locations
          unless empty?
            response[:results].first[:locations]
          end
        end

        def providedLocation
          unless empty?
            response[:results].first[:providedLocation]
          end
        end

        def options
          response[:options]
        end

      end

    end
  end
end