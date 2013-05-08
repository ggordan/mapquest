module MapquestGeolocation
  class Request < RestClient::Resource

    # The base url of the mapquest geocoding api
    API_ROOT = 'http://www.mapquestapi.com/geocoding/v1/address'

    def initialize
      super API_ROOT
    end

    def send(params)
      get :params => params
    end

  end
end