# frozen_string_literal: true
require "spec_helper"

RSpec.describe Kobanapix do
  it "has version number" do
    expect(Kobanapix::VERSION).not_to be nil
  end

  it "applies direct config" do
    api_url = "url"
    api_token = "token"

    Kobanapix.init do |config|
      config.api_url = api_url
      config.api_token = api_token
    end

    expect(Kobanapix.config.api_url).to eq(api_url)
    expect(Kobanapix.config.env).to eq(:sandbox)
    expect(Kobanapix.config.api_token).to eq(api_token)
    expect(Kobanapix.client).to be_kind_of(Kobanapix::Client)
  end

  it "applies env config" do
    token = "token"
    allow(ENV).to receive(:fetch).and_return(token)

    Kobanapix.init

    expect(Kobanapix.config.api_token).to eq(token)
    expect(Kobanapix.client).to be_kind_of(Kobanapix::Client)
  end
end
