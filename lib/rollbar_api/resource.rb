module RollbarApi
  class Resource
    attr_reader :response_json

    def initialize(response)
      response = response.body if response.is_a?(Faraday::Response)
      @response_json = if response.is_a?(String)
        JSON.parse(response)
      else
        response
      end
      @struct = RecursiveOpenStruct.new(@response_json, {recurse_over_arrays: true})
    end

    def as_json(options = {})
      @response_json
    end

    def method_missing(name, *args)
      @struct.send(name, *args)
    end
  end
end
