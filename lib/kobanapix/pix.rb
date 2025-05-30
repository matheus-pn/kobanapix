# frozen_string_literal: true

module Kobanapix
  class Pix
    attr_reader :saved, :response
    attr_accessor :params

    def saved?
      saved
    end
  
    # Helper methods
    def qrcode_url
      response&.body&.dig("data", "formats", "qrcode", "png")
    end

    def txid
      response&.body&.dig("data", "txid")
    end

    def uid
      response&.body&.dig("data", "uid")
    end

    def initialize(args = {})
      @saved = false
      @params = args
      @response = nil
    end

    def self.create(args = {})
      pix = new(args)
      pix.save
      pix
    end

    def errors
      @response&.body&.dig("errors") || []
    end

    def save
      return true if @saved

      url = Kobanapix.config.api_url
      @response = Kobanapix.client.post(url, params)
      @saved = !@response.error?
    end
  end
end
