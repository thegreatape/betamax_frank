# Betamax-Frank

Client library for integrating the betamax HTTP recording server with Frank for automated iOS testing.

## Installation

Add this line to your application's Gemfile:

    gem 'betamax_frank'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install betamax_frank

## Usage

In your features/support/env.rb, just `require 'betamax_frank'`.

Set `ENV['BETAMAX_TARGET_URL']` to the url you want betamax to record.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/betamax_frank/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
