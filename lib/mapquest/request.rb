class MapQuest
  class Request < RestClient::Resource

    # The base url of the mapquest api
    API_ROOT = 'http://www.mapquestapi.com/%s/v1/%s'

    ACCESS = {
        :geocoding => 'address',
        :directions => 'route',
        :search => 'search',
        :staticmap => 'getmap',
    }

    def initialize(method)
      super API_ROOT % [method.to_s, ACCESS[method]]
    end

    def send(params)
      get :params => params
    end

  end
end