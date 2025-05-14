require "kobanapix"

Kobanapix.init do |config|
  config.env = :sandbox # Only sandbox
  config.api_token = ENV["MY_TOKEN"]
end

# Creating a pix
pix = Kobanapix::Pix.create(
  amount: 10.0,
  pix_account_id: 276,
  expire_at: "2025-09-08T15:25:34",
  payer: {
    name: "Joao Teste",
    document_number: "74754909046",
  }
)
puts pix.inspect
# If an error occurs
pix.saved? # => false
pix.errors # => [{"code"=>"validation_error", "param"=>"amount", "detail"=>"Quantia não pode ficar em branco"}]

# Creating the long way
pix = Kobanapix::Pix.new(
  amount: 10.0,
  pix_account_id: 276,
  expire_at: "2025-09-08T15:25:34",
  payer: {
    name: "Joao Teste",
    document_number: "74754909046",
  }
)
pix.params[:amount] = 100.99
pix.save # => true

