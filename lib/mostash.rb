require 'ostruct'

require File.join(File.dirname(__FILE__), "mostash", "mostash")
MoStash = Mostash

def dbg( msg )
  file, line, method_raw = caller[0].split('/').last.split(':')
  method = method_raw.match(/^in `(.+)'/)[1] 
  puts "#{method} (#{file}##{line}): #{msg}"
end
