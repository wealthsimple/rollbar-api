# frozen_string_literal: true

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
      @struct = ResourceStruct.new(@response_json, { recurse_over_arrays: true })
    end
    delegate :inspect, to: :@struct

    def as_json(_options = {})
      @response_json
    end

    def method_missing(name, *args)
      @struct.send(name, *args)
    end

    def respond_to_missing?(method_name, _include_private = false)
      @struct.respond_to?(method_name)
    end
  end

  class ResourceStruct < RecursiveOpenStruct
    def inspect
      %(#<RollbarApi::Resource: #{JSON.pretty_generate(@table)}>)
    end
  end
end
