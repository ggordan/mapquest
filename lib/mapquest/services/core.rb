class MapQuest
  module Services
    class Core

      attr_accessor :mapquest

      def initialize(mapquest)
        @mapquest = mapquest
      end

      def call_api(api, version, call, options)
        # Remove invalid options
        options.keys.select { |k| api.class::VALID_OPTIONS.include? k }
        api_method = {
            :location => api.class::API_LOCATION,
            :version => version,
            :call => call
        }
        mapquest.request api_method, options, api.class::Response
      end

    end
  end
end