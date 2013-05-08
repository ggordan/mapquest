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
      if empty?
        raise Error
      else
        locations = []
        response['results'].first['locations'].each { |k| locations.push sym k }
        return locations
      end
    end

    def providedLocation
      unless empty?
        sym response['results'].first['providedLocation']
      end
    end

    def options
      sym response['options']
    end

    def info
      sym response['info']
    end

    def status
      return { :code => info[:statuscode], :messages => info[:messages] }
    end

    def sym(hash)
      tmp = {}
      hash.each do |k,v|
        if v.is_a? Hash
          tmp[k.to_sym] = sym v
        else
          tmp[k.to_sym] = v
        end
      end
      return tmp
    end

  end
end