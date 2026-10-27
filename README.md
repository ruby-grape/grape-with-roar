Grape API with Roar & Mongoid
=============================

[![Tests](https://github.com/ruby-grape/grape-with-roar/actions/workflows/test.yml/badge.svg?branch=with-mongoid)](https://github.com/ruby-grape/grape-with-roar/actions/workflows/test.yml?query=branch%3Awith-mongoid)
[![Rubocop](https://github.com/ruby-grape/grape-with-roar/actions/workflows/rubocop.yml/badge.svg?branch=with-mongoid)](https://github.com/ruby-grape/grape-with-roar/actions/workflows/rubocop.yml?query=branch%3Awith-mongoid)
[![Coverage Status](https://coveralls.io/repos/github/ruby-grape/grape-with-roar/badge.svg?branch=with-mongoid)](https://coveralls.io/github/ruby-grape/grape-with-roar?branch=with-mongoid)

A [Grape](https://github.com/ruby-grape/grape) API that serves HAL hypermedia with [Roar](https://github.com/trailblazer/roar) and persists splines in MongoDB with [Mongoid](https://github.com/mongodb/mongoid).

Run
---

Use Ruby 3.3 or newer and a running MongoDB 8 instance. This branch persists the Mongoid [Spline](app/models/spline.rb) model. Development and test connections default to `127.0.0.1:27017`, with separate databases configured in [config/mongoid.yml](config/mongoid.yml).

```sh
bundle install
RACK_ENV=development bundle exec puma -p 9292
```

Open [localhost:9292/api](http://localhost:9292/api) to explore the API's HAL links, or [localhost:9292/api/swagger_doc](http://localhost:9292/api/swagger_doc) for Swagger documentation.

POST and PUT JSON
-----------------

Create a persisted spline by posting a JSON object nested under `spline`:

```sh
curl --include http://localhost:9292/api/splines \
  --header 'Content-Type: application/json' \
  --data '{"spline":{"name":"demo","reticulated":true}}'
```

The response is `201 Created` with a string `id` and HAL links. Replace `ID_FROM_POST` below with that returned ID to update the same record:

```sh
curl --include --request PUT http://localhost:9292/api/splines/ID_FROM_POST \
  --header 'Content-Type: application/json' \
  --data '{"spline":{"name":"updated","reticulated":false}}'
```

The response is `200 OK`, and the changes are persisted in MongoDB. Both endpoints also accept `Content-Type: application/hal+json`. Collections use `cursor` and `size` pagination parameters.

Hyperclient
-----------

[Hyperclient](https://github.com/codegram/hyperclient) can create, list, update, and delete splines through the API. See [splines_endpoint_with_hyperclient_spec.rb](spec/api/splines_endpoint_with_hyperclient_spec.rb) for the corresponding request coverage.

With the server running, open a second terminal:

```sh
bundle exec irb
```

Reuse one client for this sequence. Hyperclient's default middleware encodes Ruby Hash request bodies as HAL JSON, and the returned self links handle each branch's identifier format. The final call deletes only the spline created by this example, not the collection:

```ruby
require 'hyperclient'

client = Hyperclient.new('http://localhost:9292/api')
spline = client.splines._post(spline: { reticulated: true })
puts spline._links.self._url
puts spline.reticulated

spline = spline._put(spline: { reticulated: false })
puts spline.reticulated

client.splines(size: 2).each do |item|
  puts "#{item._links.self._url}: #{item.reticulated}"
end

spline._delete
```

Passing `size: 2` expands a fresh collection link after POST instead of reusing its cached response. Hyperclient follows pagination links automatically.

On `with-mongoid`, create and update persist changes in MongoDB, and the final delete removes only the created record. Collection links use cursor-based pagination; HAL self links handle the model's string IDs without hard-coding them in the client.

Development
-----------

Run the test suite and RuboCop:

```sh
bundle exec rake spec
bundle exec rubocop
# Run both:
bundle exec rake
```

Tests clear the configured test database. Do not point that connection at data you want to keep.

Tests generate HTML coverage in `coverage/index.html` and LCOV coverage in `coverage/lcov.info`. CI tests Ruby 3.3, 3.4, and 4.0 across Grape 2, 3, and 4, including Rack 2 and 3 compatibility, and uploads combined coverage to Coveralls.

The committed lockfile provides the default development bundle. CI resolves each compatibility combination independently using `GRAPE_VERSION` and `RACK_VERSION`. To try another combination locally, save the lockfile first, remove it, and run `bundle install` with those environment variables; restore the default lockfile afterward.

Each active example branch runs its own branch-specific test and lint workflows. This branch provisions a health-checked MongoDB 8.0 service for every test job on Ubuntu 22.04; MongoDB 8.0 rejects Linux 6.19 and newer, including some updated Ubuntu 24.04 runners.

Other Examples
--------------

The three active branches share the HAL API, with different model and persistence examples:

| Branch | Model | Database |
|--------|-------|----------|
| [master](https://github.com/ruby-grape/grape-with-roar/tree/master) | ActiveModel | None; generated splines, nonpersistent writes |
| [with-mongoid](https://github.com/ruby-grape/grape-with-roar/tree/with-mongoid) | Mongoid | MongoDB |
| [with-activerecord](https://github.com/ruby-grape/grape-with-roar/tree/with-activerecord) | ActiveRecord | PostgreSQL |

Copyright and License
---------------------

Copyright (c) 2014-2016 Daniel Doubrovkine

MIT License, see [LICENSE](LICENSE) for details.
