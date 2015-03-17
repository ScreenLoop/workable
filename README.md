# Workable

[![Code Climate](https://codeclimate.com/github/emq/workable/badges/gpa.svg)](https://codeclimate.com/github/emq/workable)
[![Build Status](https://travis-ci.org/emq/workable.svg?branch=master)](https://travis-ci.org/emq/workable)
[![Coverage Status](https://coveralls.io/repos/emq/workable/badge.png?branch=master)](https://coveralls.io/r/emq/workable?branch=master)
[![Gem Version](https://badge.fury.io/rb/workable.svg)](http://badge.fury.io/rb/workable)
[![Dependency Status](https://gemnasium.com/emq/workable.svg)](https://gemnasium.com/emq/workable)

Dead-simple Ruby API client for [workable.com][1]. No extra runtime dependencies. Ruby >= 1.9.3.

Uses v2 API provided by workable.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'workable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install workable

## Usage

Internal interface / api is in early stage, so far you can:
- fetch jobs
- fetch job details
- fetch candidates for given job

**Example:**

``` ruby
client = Workable::Client.new(api_key: 'api_key', subdomain: 'your_subdomain')

# takes optional phase argument (string): 'published' (default), 'draft', 'closed' or 'archived'
client.jobs # => [#<Workable::Job>, #<Workable::Job>]

shortcode = 'job_shortcode'

# API queries are not cached (at all) - it's up to you to cache results one way or another

client.job_details(shortcode) # => #<Workable::Job>
client.job_candidates(shortcode) # => Array of hashes

# Possible errors (each one inherits from Workable::Errors::WorkableError)
Workable::Errors::InvalidConfiguration # missing api_key / subdomain
Workable::Errors::NotAuthorized   # wrong api key
Workable::Errors::InvalidResponse # something when wrong during the request?
Workable::Errors::NotFound        # 404 from workable
Workable::Errors::RequestToLong   # When the requested result takes to long to calculate, try limiting your query
```

## Missing/Todo

Pull requests are welcomed. So far this gem does not provide:

- candidates import
- some sane way for parsing candidates json response

_(Personally I don't really need/use it)_

## Contributing

1. Fork it ( https://github.com/emq/workable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[1]: http://workable.com/
