# frozen_string_literal: true

RSpec.describe Kobanapix::Pix do
  before do
    @params = {
      amount: 10.0,
      pix_account_id: 276,
      expire_at: "2025-09-08T15:25:34",
      payer: {
        name: "Joao Teste",
        document_number: "74754909046"
      }
    }
  end

  it "has correct default state" do
    pix = Kobanapix::Pix.new(@params)
    expect(pix.errors).to eq([])
    expect(pix.saved?).to eq(false)
  end

  it "updates state after saving" do
    stub_request(:post, Kobanapix.config.api_url).to_return(status: 200, body: '{"success": true}')
    pix = Kobanapix::Pix.new(@params)
    pix.save

    expect(pix.errors).to eq([])
    expect(pix.saved?).to eq(true)
    expect(pix.response.body["success"]).to eq(true)
  end

  it "saves using create" do
    stub_request(:post, Kobanapix.config.api_url).to_return(status: 200, body: '{"success": true}')
    pix = Kobanapix::Pix.create(@params)
    expect(pix.errors).to eq([])
    expect(pix.saved?).to eq(true)
    expect(pix.response.body["success"]).to eq(true)
  end

  it "updates state after error" do
    stub_request(:post, Kobanapix.config.api_url).to_return(status: 400, body: '{"errors": [{"problem": true}]}')
    pix = Kobanapix::Pix.new(@params)
    pix.save

    expect(pix.errors).not_to be_empty
    expect(pix.saved?).to eq(false)
  end
end
