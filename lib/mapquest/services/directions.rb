class MapQuest
  module Services
    class Directions < Core

      def get(params)
        if params.has_key? :from && :to
          response = mapquest.request :directions, params, Response
        else
          raise Error
        end
      end

      class Response < MapQuest::Response

        def route
          response[:route]
        end

      end

    end
  end
end