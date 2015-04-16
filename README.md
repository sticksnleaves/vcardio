# VCardio

[![Build Status](https://travis-ci.org/sticksnleaves/vcardio.svg?branch=master)](https://travis-ci.org/sticksnleaves/vcardio)
[![Code Climate](https://codeclimate.com/github/sticksnleaves/vcardio/badges/gpa.svg)](https://codeclimate.com/github/sticksnleaves/vcardio)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vcardio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vcardio

## Usage

### Create a vCard

VCardio comes packed with an easy to use vCard building DSL:

```ruby
vcard = VCardio::VCard.new('3.0') do
  tel '(555) 555-5555', type: %w(HOME WORK)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/vcardio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
