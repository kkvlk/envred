# envred

**Environment config loader backed by Redis**

This is a simple tool in flavor of `envdir` from daemontools package. Instead of
loading environment from directory, it loads it for redis hash specified in
the central url. See examples section for details.

## Installation

Install via rubygems:

    $ gem install envred

## Usage

Run application with environment loaded from Redis server:

    $ envred localhost:6379/0/~myapp myapp --do something

The `localhost:6379` is host anf port of Redis server, `0` is the number of
the database to load stuff from, finally, `myapp` is the key which keeps
the data as hash.

## Hacking

If you wanna hack on the repo for some reason, first clone it, then run:

    $ bundle install

Now you should be able to run tests:

    $ rake

## Contributing

1. Work on your changes in a feature branch.
2. Make sure that tests are passing.
3. Send a pull request.
4. Wait for feedback.

## Copyrights

Copyright (c) by Kris Kovalik <hi@kkvlk.me>

Released under MIT License. Check [LICENSE.txt](LICENSE.txt) for details.
