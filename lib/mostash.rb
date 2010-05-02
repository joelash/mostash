require 'ostruct'

require File.join(File.dirname(__FILE__), "mostash", "mostash")

def dbg( msg )
  file_name = __FILE__.split( '/' ).last
  puts "#{file_name} ##{__LINE__}: #{msg}"
end
