<div style='float: right'>
[![Build Status](https://secure.travis-ci.org/educabilia/memmo.png?branch=master)](https://travis-ci.org/educabilia/memmo)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/educabilia/memmo)
</div>

Memmo
=====

Memmo is a small library for creating key-based, in-memory caches in Ruby.

It features thread safety and TTLs.

Usage
-----

```ruby

require "memmo"

$memmo = Memmo.new

$memmo.register(:popular_posts, ttl: 60) do
  # Somewhat expensive query
  Post.find(...)
end

# This call will trigger a miss and will run our expensive query.
$memmo[:popular_posts].each do |post|
  puts(post)
end

# This call will be fast for the next 60 seconds.
$memmo[:popular_posts]
```
