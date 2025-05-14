# Kobanapix

Mock "gem/library" that uses the Kobana api to create a Pix transfer.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Usage

This code can be used as shown in `examples/pix_example.rb`:
```ruby
require "kobanapix"

Kobanapix.init do |config|
  config.env = :sandbox # Only sandbox
  # If not specified will be pulled from ENV["KOBANA_TOKEN"]
  config.api_token = "MY_TOKEN"
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
```

For testing purposes it can be used in the console as shown below:
> Start `bin/console` after installing dependencies

> Initialize with your sandbox token
```ruby
Kobanapix.init { |config| config.api_token = "YOUR_API_TOKEN" }
```
> Create a pix object, changing parameters
```ruby
pix = Kobanapix::Pix.new(amount: 1.0, pix_account_id: 1,expire_at:"2025-09-08T15:25:34", payer: {name: "Joao Teste",document_number: "74754909046"})
```
> Save the object
```ruby
pix.save
# => true
```
> Inspect the object
```ruby
pix.errors
# => []
pix.saved?
# => true
pix.qrcode_url
# => "https://sandbox.kdoc.to/1/6EzNXN9Mg-Kj/qrcode.png"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
