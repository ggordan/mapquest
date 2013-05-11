class MapQuest
  class Request < RestClient::Resource

    # The base url of the mapquest api
    API_ROOT = 'http://www.mapquestapi.com/%s/v%s/%s'

    ACCESS = {
        :geocoding => { :v => '1', :call => 'address'},
        :directions => { :v => '1', :call => 'route'},
        :search => { :v => '2', :call => 'search'},
        :staticmap => { :v => '4', :call => 'staticmap'},
    }

    def initialize(method)
      super API_ROOT % [method.to_s, ACCESS[method][:v], ACCESS[method][:call]]
    end

    def send(params)
      get :params => params
    end

  end
end