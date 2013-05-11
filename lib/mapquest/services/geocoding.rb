class MapQuest
  module Services
    class Geocoding < Core

      def decode(params)
        raise Error unless params.has_key? :location
        response = mapquest.request :geocoding, params
      end

    end
  end
end