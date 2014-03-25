# envred

**Environment config loader backed by Redis.**

![Build Status](https://app.wercker.com/status/0aa6c6c8ed8cd84fb608604ae7dc7604/s/)

This is a simple tool in flavor of `envdir` from daemontools package. Instead of
loading environment from directory, it loads it for redis hash specified in
the central url. See examples section for details.

## Installation

Install via rubygems:

    $ gem install envred

## Usage

Set some variables first:

    $ envred -c localhost:6379/0 -a myapp set FOO 1 BAR 2 BAZ 3

The `localhost:6379/0` is host, port and number of Redis database to load
stuff from, and `myapp` is the key which keeps the data as hash.

Now you can run any application with environment loaded from Redis server:

    $ envred -c localhost:6379/0 -a myapp wrap myapp --do something

To list all your variables use:

    $ envred -c localhost:6379/0 list

You can remove specific keys or purge all config:

    $ envred -c localhost:6379/0 -a myapp unset FOO BAR
    $ envred -c localhost:6379/0 -a myapp purge

Note! Instead of specifying central url all the time, you can store it in
`ENVRED_CENTRAL` env variable:

    $ export ENVRED_CENTRAL=localhost:6379/0

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

Copyright (c) by Kris Kovalik <<hi@kkvlk.me>>

Released under MIT License. Check [LICENSE.txt](LICENSE.txt) for details.
