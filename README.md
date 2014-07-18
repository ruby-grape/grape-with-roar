Grape API with Roar
===================

[![Build Status](https://secure.travis-ci.org/dblock/grape-with-roar.png)](http://travis-ci.org/dblock/grape-with-roar)

A [Grape](http://github.com/intridea/grape) API that uses [Roar](https://github.com/apotonick/roar).

See
---

There's a deployed [grape-with-roar on Heroku](http://grape-with-roar.herokuapp.com/api/).

Run
---

```
$ bundle install
$ rackup

[2013-06-20 08:57:58] INFO  WEBrick 1.3.1
[2013-06-20 08:57:58] INFO  ruby 1.9.3 (2013-02-06) [x86_64-darwin11.4.2]
[2013-06-20 08:57:58] INFO  WEBrick::HTTPServer#start: pid=247 port=9292
```

### Hello World

Navigate to [localhost:9292/api](http://localhost:9292/api) with a browser. This is a hypermedia API, so all links are clickable.

Copyright and License
---------------------

Copyright (c) 2014 Daniel Doubrovkine

MIT License, see [LICENSE](LICENSE) for details.
