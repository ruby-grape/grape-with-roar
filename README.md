Grape API with Roar
===================

[![test](https://github.com/ruby-grape/grape-with-roar/actions/workflows/test.yml/badge.svg)](https://github.com/ruby-grape/grape-with-roar/actions/workflows/test.yml)

A [Grape](http://github.com/ruby-grape/grape) API that uses [Roar](https://github.com/apotonick/roar).

Run
---

```
$ bundle install
$ rackup

[2013-06-20 08:57:58] INFO  WEBrick 1.3.1
[2013-06-20 08:57:58] INFO  ruby 1.9.3 (2013-02-06) [x86_64-darwin11.4.2]
[2013-06-20 08:57:58] INFO  WEBrick::HTTPServer#start: pid=247 port=9292
```

Navigate to [localhost:9292/api](http://localhost:9292/api) with a browser. This is a hypermedia API, so all links are clickable.

In Chrome, best viewed with the [JSONView Plugin](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en).

Hyperclient
-----------

This is a good demo to use with [Hyperclient](https://github.com/codegram/hyperclient). Check out [splines_endpoint_with_hyperclient_spec.rb](/spec/api/splines_endpoint_with_hyperclient_spec.rb) for a complete example that retrieves, creates, updates and deletes splines.

ActiveModel
-----------

This project uses ActiveModel and defines a dummy [Spline](app/models/spline.rb) class.

ActiveRecord
------------

Check out the [with-activerecord branch](https://github.com/ruby-grape/grape-with-roar/tree/with-activerecord) for a complete example that uses ActiveRecord and a PostgreSQL database.

Mongoid
-------

Check out the [with-mongoid branch](https://github.com/ruby-grape/grape-with-roar/tree/with-mongoid) for a complete example that uses Mongoid and a MongoDB database.

Copyright and License
---------------------

Copyright (c) 2014-2025 Daniel Doubrovkine

MIT License, see [LICENSE](LICENSE) for details.
