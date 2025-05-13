# frozen_string_literal: true

module Kobanapix
  class Config
    API_URL = {
      sandbox: "https://api-sandbox.kobana.com.br/v2/charge/pix"
    }.freeze

    attr_accessor :env, :api_token, :api_url

    # Default values
    def initialize
      @env = :sandbox
      @api_token = ENV.fetch("KOBANA_TOKEN", nil)
      @api_url = API_URL[@env]
    end

    def setup_client
      Client.new(auth_token: @api_token)
    end
  end
end
