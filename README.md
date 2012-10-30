Mostash
=======

Mostash is an object that has several identities. Think of it Hash with the tendencies of [OpenStruct](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/ostruct/rdoc/OpenStruct.html). The name comes from the phase "more open struct/hash".

Basic Example
-------------

    require 'mostash'

    my_hash = {
      :foo => 'some value',
      :bar => 'another value'
    }
    
    mostash = Mostash.new(my_hash)
    
    mostash[:foo]
    => 'some value'
    
    mostash['foo']
    => 'some value'
    
    mostash.foo
    => 'some value'

Nested Hashes
-------------
Mostash support nested hash in the same way that it supports any other hash.

    require 'mostash'

    mostash = Mostash.new(
      :foo   => 'bar',
      :inner => {
        :hello => 'world'
      }
    )

    mostash[:inner][:hello]
    => 'world'

    mostash['inner']['hello']
    => 'world'

    mostash.inner.hello
    => 'world'


Mostash also handles setting of new values

    require 'mostash'
    mostash = Mostash.new

    mostash.new_value = { :foo => 'bar', :inner => { 'hello' => 'world' } }

    mostash[:new_value][:foo]
    => 'bar'

    mostash[:new_value].inner.hello
    => 'world'

As you can see, pretty mush all the ways of accessing a key within a hash are supported and will hash down to the same spot in the hash.

Contributing to mostash
=======================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=========

Copyright (c) 2012 Joel Friedman. See LICENSE.txt for
further details.
