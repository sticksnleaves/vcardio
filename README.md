# VCardio

[![Build Status](https://travis-ci.org/sticksnleaves/vcardio.svg?branch=master)](https://travis-ci.org/sticksnleaves/vcardio)
[![Code Climate](https://codeclimate.com/github/sticksnleaves/vcardio/badges/gpa.svg)](https://codeclimate.com/github/sticksnleaves/vcardio)
[![Coverage Status](https://coveralls.io/repos/sticksnleaves/vcardio/badge.svg?branch=master)](https://coveralls.io/r/sticksnleaves/vcardio?branch=master)

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

VCardio comes packed with a powerful and easy to use DSL:

```ruby
vcard = VCardio::VCard.new('3.0') do
  fn %w(Smith Anthony)
  org 'Sticksnleaves'
  tel '(555) 555-5555', type: 'HOME'
  tel '(555) 555-5556', type: 'WORK'
  item1.gender 'M'
end
```

To convert your vCard to a string just call `to_s`:

```ruby
vcard.to_s # => VCARD:BEGIN
           #    VERSION:3.0
           #    FN:Smith;Anthony
           #    ORG:Sticksnleaves
           #    TEL;TYPE=HOME:(555) 555-5555
           #    TEL;TYPE=WORK:(555) 555-5556
           #    item1.GENDER:M
           #    VCARD:END
```

Or write the vCard to a file:

```ruby
vcard.to_file('/path/to/file.vcf')
```

### Parsing vCards

If you already have a vCard and want to manipulate it into Ruby just call
`VCardio::VCard#parse`.

```ruby
file  = File.open('path/to/file.vcf')
vcard = VCardio::VCard.parse(file)

vcard.fn[0].value                # => ['Smith', 'Anthony']
vcard.org[0].value               # => 'Sticksnleaves'
vcard.tel[0].value               # => '(555) 555-5555'
vcard.tel[1].parameters[0].value # => 'HOME'
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
