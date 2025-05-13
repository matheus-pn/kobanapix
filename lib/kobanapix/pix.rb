# frozen_string_literal: true

module Kobanapix
  class Pix
    FIELDS = %i[amount payer_document_number payer_name
    pix_account_id expire_at].freeze

    attr_reader :params, :saved

    def initialize(**params)
      @saved = false
      @params = params.select { |k, _| FIELDS.include?(k) }
      @response = nil
    end

    def self.create(**args)
      pix = new(**args)
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
