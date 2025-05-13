# frozen_string_literal: true

# Using net/http to reduce dependencies, since this is a gem
require "net/http"
require "json"

#  # Make net/http a little easier to work with
module Kobanapix
  class Response
    attr_reader :body, :status, :message, :has_error

    def initialize(http_res)
      @body = JSON.parse(http_res.body)
      @status = http_res.code
      @message = http_res.message
      @has_error = 
        case http_res
        when Net::HTTPClientError, Net::HTTPServerError then true
        else false
        end
    end

    def error?
      has_error
    end
  end

  class Client
    def initialize(auth_token:)
      @auth_token = auth_token
    end

    def post(url, payload)
      url = URI(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["authorization"] = "Bearer #{@auth_token}"
      request["accept"] = "application/json"
      request["content-type"] = "application/json"
      request.body = payload.to_json
      res = http.request(request)
      Response.new(res)
    end
  end
end
