module RollbarApi
  class Request
    attr_reader :method, :path, :params
    def initialize(method:, path:, params:)
      @method = method
      path = "/#{path}" unless path.start_with?("/")
      @path = path
      @params = params
    end

    def execute
      connection.send(method) do |request|
        if method == :get
          request.url("#{path}?#{params.to_param}")
        else
          request.url(path)
          request.body = body_to_json(params) if params.present?
        end

        request.headers.merge!({
          "Accept" => "application/json",
          "Content-Type" => "application/json",
        })
        request
      end
    end

  private

    def connection
      Faraday.new(url: "https://api.rollbar.com") do |faraday|
        faraday.use Faraday::Response::RaiseError
        faraday.response :logger, RollbarApi.logger, bodies: false
        faraday.adapter Faraday.default_adapter
      end
    end

    def body_to_json(body)
      if body
        body.is_a?(Array) || body.is_a?(Hash) ? body.to_json : body
      else
        nil
      end
    end
  end
end
