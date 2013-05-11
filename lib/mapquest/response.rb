class MapQuest
  class Response

    attr_reader :response

    def initialize(res)
      @response = JSON.parse(res, :symbolize_names => true)
    end

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

    def info
      response[:info]
    end

    def status
      return { :code => info[:statuscode], :messages => info[:messages] }
    end

  end
end