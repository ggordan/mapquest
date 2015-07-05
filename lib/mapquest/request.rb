class MapQuest
  class Request < RestClient::Resource

    RestClient.log =
  Object.new.tap do |proxy|
    def proxy.<<(message)
      Rails.logger.info message
    end
  end

    # The base url of the mapquest api
    API_ROOT = 'http://%smapquestapi.com/%s/v%s/%s'

    def initialize(method)
      isOMQ = method[:omq] ? "open." : ""
      super API_ROOT % [isOMQ, method[:location], method[:version], method[:call]]
    end

    def query(params)
      get :params => params
    end

  end
end
