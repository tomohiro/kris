Kris
================================================================================

IRC bot library - Pluggable, and very simple

[![Dependency Status](https://gemnasium.com/Tomohiro/kris.png)](https://gemnasium.com/Tomohiro/kris)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Tomohiro/kris)
[![endorse](http://api.coderwall.com/tomohiro/endorsecount.png)](http://coderwall.com/tomohiro)


---


Requirements
--------------------------------------------------------------------------------

- Ruby 1.9.3 or lator
- Zircon


Getting started
--------------------------------------------------------------------------------


### Bot project structure

    my-bot-project
        |-- Gemfile
        |-- Procfile
        |-- MyBot
        `-- plugin
            |-- reply.rb
            `-- crawler.rb


### Install the kris

RubyGems.org

Coming soon...


Gemfile

    gem 'kris', :git => 'git://github.com/Tomohiro/kris.git'


### Bootstarp Bot

    $ vi my-bot-project/MyBot

```ruby
#!/usr/bin/env ruby

require 'kris'

Kris::Session.new(
  :server   => 'chat.freenode.net',
  :port     => 6667,
  :channel  => '#my-bot-channel',
  :nickname => 'MyBot',
  :username => 'MyBot',
  :realname => 'MyBot'
).start
```


### Plugin example

Response

```ruby
class Reply < Kris::Plugin
  def response(message)
    case message.body.downcase
    when /hello/
      reply(message.to, message.from, 'Hello!')
    end
  end
end
```

Notification

```ruby
class Crawler < Kris::Plugin
  def notify
    crawl_datas do |new_data|
      notice('#notify-channel', new_data)
    end
  end

  private
    def crawl_datas
      # do something
    end
end
```


### Run

    $ bundle exec ruby MyBot




LICENSE
--------------------------------------------------------------------------------

&copy; 2012 Tomohiro, TAIRA.
This project is licensed under the MIT license.
See LICENSE for details.
