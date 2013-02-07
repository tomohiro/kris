Kris
================================================================================

IRC bot library - Pluggable, and very simple

[![Gem Version](https://badge.fury.io/rb/kris.png)](http://badge.fury.io/rb/kris)
[![Dependency Status](https://gemnasium.com/Tomohiro/kris.png)](https://gemnasium.com/Tomohiro/kris)
[![Stillmaintained](http://stillmaintained.com/Tomohiro/kris.png)](http://stillmaintained.com/Tomohiro/kris)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Tomohiro/kris)


---


Requirements
--------------------------------------------------------------------------------

- Ruby 1.9.3 or lator


Getting started
--------------------------------------------------------------------------------


### Install the kris

#### RubyGems.org

    gem install kris


#### Bundler

Edit a `Gemfile`

    gem 'kris', :git => 'git://github.com/Tomohiro/kris.git'


Install

    $ bundle install --path vendor/bundle


### Bot project directory structure

    my-bot-project
        |-- Gemfile
        |-- MyBot
        `-- plugin
            |-- reply.rb
            `-- hello.rb


#### Bootstrap Bot

    $ vi my-bot-project/MyBot

```ruby
#!/usr/bin/env ruby

require 'kris'

Kris::Session.new(
  server:   'chat.freenode.net',
  port:     6667,
  channel:  '#my-bot-channel',
  nickname: 'MyBot',
  username: 'MyBot',
  realname: 'MyBot',
  # Optional settings is below (Not Required)
  channels: %(#foo #bar #baz),  # If you want to join another channels with additional
  plugin_path: '/home/kris/my-bot-plugins'  # If you want to specify a defferent path
).start
```


### Plugin example

Response

```ruby
class Reply < Kris::Plugin
  def on_privmsg(message)
    case message.body.downcase
    when /hello/
      reply(message.to, message.from, 'Hello!')
    end
  end

  def on_topic(message)
    notice(message.to, "Now topic is #{message.body}")
  end
end
```

Scheduled notification

```ruby
class Hello < Kris::Plugin
  def notify
    sleep 300
    notice('#notify-channel', 'Hello')
  end
end
```


### Run

    $ bundle exec ruby MyBot




LICENSE
--------------------------------------------------------------------------------

&copy; 2012 - 2013 Tomohiro TAIRA.
This project is licensed under the MIT license.
See LICENSE for details.
