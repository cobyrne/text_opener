# TextOpener

TextOpener is like Letter Opener but for text messages sent via Twilio.
Messages will be previewed in the browser instead of actually sent.

## Installation

Add this line to your application's Gemfile:

    gem 'text_opener'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install text_opener

## Usage

Call `TextOpener.install` to stub Twilio texts sent with the twilio-ruby gem.
If you're using Rails you may want to add an initializer, or call it directly
from config/environment/development.rb

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
