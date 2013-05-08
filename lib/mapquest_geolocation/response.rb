module MapquestGeolocation
  class Response

    attr_reader :response

    def initialize(res)
      @response = JSON.parse(res)
    end

    def empty?
      true if response['results'].first['locations'].any? else false
    end

    def locations
      []
      unless empty?
        response['results'].first['locations']
      end
    end

  end
end