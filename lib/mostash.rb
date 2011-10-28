require 'ostruct'

require File.join(File.dirname(__FILE__), "mostash", "mostash")
MoStash = Mostash

def dbg(obj, msg=nil)
  file, line, method_raw = caller[0].split('/').last.split(':')
  method = method_raw.match(/^in `(.+)'/)[1] 
  #puts "#{method} (#{file}##{line}): #{msg}"
  msg += " " if msg
  puts "#{msg}#{obj.inspect}"
  obj
end
