#!/usr/bin/ruby
#-
# binlib.rb - binary control module
#
# == example
#
#   p BinLib.to_int8(0xff)   #=> -1
#   p BinLib.to_uint8(0xff)  #=> 255
#
#   bit mask
#   p BinLib.to_int8(0xff80)   #=> -128
#   p BinLib.to_uint8(0xff80)  #=> 128
#
#   cat(join) and split
#   p BinLib.cat8([0xaa, 0x55])         #=> 0xaa55
#   p BinLib.cat8([0xaa, 0xff, 0x55])   #=> 0xaaff55
#   p BinLib.cat8([0xaa00, 0x55])       #=> 0xaa0055
#   p BinLib.split8(0xaa55)             #=> [0xaa, 0x55]
#   p BinLib.split8(0xaa0055)           #=> [0xaa, 0x0, 0x55]
#

module BinLib
  list = {
    :to_int8 => "c",
    :to_uint8 => "C",
    :to_int16 => "s",
    :to_uint16 => "S",
    :to_int32 => "l",
    :to_uint32 => "L",
  }
  
  list.each do |name, type|
    define_method(name) do |val|
      [val].pack(type).unpack(type)[0]
    end
    module_function name
  end
  
  def cat8(val)
    ret = 0;
    val.each{ |e| ret = (ret << 8) | e }
    ret
  end
  
  alias join8 cat8
  
  def split8(val)
    ret = []
    while val != 0
      ret.unshift(val & 0xff)
      val >>= 8
    end
    ret
  end
end

# sample
if $0 == __FILE__
  p BinLib.to_int8(0xff)
  p BinLib.to_uint8(0xff)

  include BinLib
  p to_int8(0xff)
  p to_uint8(0xff)
  p to_int16(0xffff)
  p to_uint16(0xffff)
  p to_int32(0xffffffff)
  p to_uint32(0xffffffff)

  p to_int8(0xff80)
  p to_uint8(0xff80)

  puts "%X" % cat8([0xaa, 0x55])
  puts "%X" % cat8([0xaa, 0xff, 0x55])
  puts "%X" % cat8([0xaa00, 0x55])
  puts "[%X, %X]" % split8(0xaa55)
  puts "[%X, %X, %X]" % split8(0xaa0055)
end
