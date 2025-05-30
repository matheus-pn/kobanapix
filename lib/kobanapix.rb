# frozen_string_literal: true
require "kobanapix/config"
require "kobanapix/rest"
require "kobanapix/pix"
require "kobanapix/version"

module Kobanapix
  class << self
    attr_reader :config, :client

    def init
      @config = Config.new
      yield(@config) if block_given?
      @client = config.setup_client
    end
  end
end

Kobanapix.init
