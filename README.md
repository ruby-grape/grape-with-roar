Grape API with Roar & Mongoid
=============================

[![Build Status](https://travis-ci.org/ruby-grape/grape-with-roar.svg?branch=with_mongoid)](https://travis-ci.org/ruby-grape/grape-with-roar?branch=with_mongoid)
[![Dependency Status](https://gemnasium.com/ruby-grape/grape-with-roar.svg?branch=with_mongoid)](https://gemnasium.com/ruby-grape/grape-with-roar?branch=with_mongoid)
[![Code Climate](https://codeclimate.com/github/ruby-grape/grape-with-roar.svg?branch=with_mongoid)](https://codeclimate.com/github/ruby-grape/grape-with-roar?branch=with_mongoid)

A [Grape](http://github.com/ruby-grape/grape) API that uses [Roar](https://github.com/apotonick/roar) and Mongoid with a MongoDB database.

Run
---

```
$ bundle install
$ rackup

[2013-06-20 08:57:58] INFO  WEBrick 1.3.1
[2013-06-20 08:57:58] INFO  ruby 1.9.3 (2013-02-06) [x86_64-darwin11.4.2]
[2013-06-20 08:57:58] INFO  WEBrick::HTTPServer#start: pid=247 port=9292
```

Try with Hyperclient and `irb`.

```
require 'hyperclient'
```

Create some splines.

```ruby
client = Hyperclient.new('http://localhost:9292/api')

3.times do |i|
  client.splines._post(spline: { name: i.to_s, reticulated: [true, false].sample })
end
```

Show splines.

```ruby
client = Hyperclient.new('http://localhost:9292/api')

client.splines.each do |spline|
  puts "spline #{spline.id} #{spline.reticulated ? 'is' : 'is not'} reticulated"
end
```

Delete splines.

```ruby
client = Hyperclient.new('http://localhost:9292/api')

client.splines.each(&:_delete)
```

### Hello World

Navigate to [localhost:9292/api](http://localhost:9292/api) with a browser. This is a hypermedia API, so all links are clickable.

Hyperclient
-----------

This is a good demo to use with [Hyperclient](https://github.com/codegram/hyperclient). Check out [splines_endpoint_with_hyperclient_spec.rb](/spec/api/splines_endpoint_with_hyperclient_spec.rb) for a complete example that retrieves, creates, updates and deletes splines.

ActiveRecord
------------

This project uses Mongoid and defines a dummy [Spline](app/models/spline.rb) class. Check out the [master branch](https://github.com/ruby-grape/grape-with-roar) for a complete example that uses ActiveModel and [with-activerecord branch](https://github.com/ruby-grape/grape-with-roar/tree/with-activerecord) for a complete example that uses ActiveRecord and a PostgreSQL database.

Copyright and License
---------------------

Copyright (c) 2014-2016 Daniel Doubrovkine

MIT License, see [LICENSE](LICENSE) for details.
