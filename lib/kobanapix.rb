# frozen_string_literal: true

require_relative "kobanapix/version"

module Kobanapix
  class Pix
    attr_accessor :amount
    attr_accessor :payer_document_number
    attr_accessor :payer_name
    attr_accessor :payer_address_street
    attr_accessor :payer_address_number
    
  end

  class Payer
  end


end
