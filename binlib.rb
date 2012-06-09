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
#   p BinLib.cat([0xaa, 0x55])         #=> 0xaa55
#   p BinLib.cat([0xaa, 0xff, 0x55])   #=> 0xaaff55
#   p BinLib.cat([0xaa00, 0x55])       #=> 0xaa0055
#   p BinLib.split(0xaa55)             #=> [0xaa, 0x55]
#   p BinLib.split(0xaa0055)           #=> [0xaa, 0x0, 0x55]
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
  
  list.each do |fname, type|
    define_method(fname) do |val|
      [val].pack(type).unpack(type)[0]
    end
    module_function fname
  end
  
  module_function
  
  def cat(val)
    ret = 0;
    val.each do |e| 
      octet(e).times do
        ret <<= 8
      end
      ret |= e
    end
    ret
  end
  
  alias join cat
  
  def split(val)
    ret = []
    while val != 0
      ret.unshift(val & 0xff)
      val >>= 8
    end
    ret
  end
  
  def octet(val)
    count = 0
    until val == 0
      count += 1
      val >>= 8
    end
    count
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

  puts "%X" % cat([0xaa, 0x55])
  puts "%X" % cat([0xaa, 0xff, 0x55])
  puts "%X" % cat([0xaa00, 0x55])
  puts "[%X, %X]" % split(0xaa55)
  puts "[%X, %X, %X]" % split(0xaa0055)
end
