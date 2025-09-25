Grape API with Roar
===================

[![test](https://github.com/ruby-grape/grape-with-roar/actions/workflows/test.yml/badge.svg?branch=with-activerecord)](https://github.com/ruby-grape/grape-with-roar/actions/workflows/test.yml)

A [Grape](http://github.com/intridea/grape) API that uses [Roar](https://github.com/apotonick/roar) and ActiveRecord with a PostgreSQL database.

Run
---

```
$ bundle install
$ rake db:create db:migrate
$ rackup

[2013-06-20 08:57:58] INFO  WEBrick 1.3.1
[2013-06-20 08:57:58] INFO  ruby 1.9.3 (2013-02-06) [x86_64-darwin11.4.2]
[2013-06-20 08:57:58] INFO  WEBrick::HTTPServer#start: pid=247 port=9292
```

### Hello World

Navigate to [localhost:9292/api](http://localhost:9292/api) with a browser. This is a hypermedia API, so all links are clickable.

Hyperclient
-----------

This is a good demo to use with [Hyperclient](https://github.com/codegram/hyperclient). Check out [splines_endpoint_with_hyperclient_spec.rb](/spec/api/splines_endpoint_with_hyperclient_spec.rb) for a complete example that retrieves, creates, updates and deletes splines.

ActiveModel
-----------

This branch uses ActiveRecord with a PostgreSQL database and defines a [Spline](app/models/spline.rb) model. Check out the [master branch](https://github.com/ruby-grape/grape-with-roar) for an example using ActiveModel.

Copyright and License
---------------------

Copyright (c) 2014-2016 Daniel Doubrovkine

MIT License, see [LICENSE](LICENSE) for details.
