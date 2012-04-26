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
  module_function
  def to_int8(val)
    [val].pack("c").unpack("c")[0]
  end
  
  def to_uint8(val)
    [val].pack("C").unpack("C")[0]
  end
  
  def to_int16(val)
    [val].pack("s").unpack("s")[0]
  end
  
  def to_uint16(val)
    [val].pack("S").unpack("S")[0]
  end
  
  def to_int32(val)
    [val].pack("l").unpack("l")[0]
  end
  
  def to_uint32(val)
    [val].pack("L").unpack("L")[0]
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
