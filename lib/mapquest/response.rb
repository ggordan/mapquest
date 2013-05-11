class MapQuest
  class Response

    attr_reader :response

    def initialize(res)
      @response = JSON.parse(res, :symbolize_names => true)
    end

    def info
      response[:info]
    end

    def copyright
      info[:copyright]
    end

    def status
      return :code => info[:statuscode], :messages => info[:messages]
    end

  end
end