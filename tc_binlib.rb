#!/usr/bin/ruby
require "test/unit"

require_relative "binlib"

class BinLibTest < Test::Unit::TestCase
  def test_toxx
    assert_equal( BinLib.to_int8(0xff), -1 )
    assert_equal( BinLib.to_uint8(0xff), 255 )
    assert_equal( BinLib.to_int8(0xff80), -128 )
    assert_equal( BinLib.to_uint8(0xff80), 128 )

    assert_equal( BinLib.to_int16(0xffff), -1 )
    assert_equal( BinLib.to_uint16(0xffff), 65535 )
    assert_equal( BinLib.to_int32(0xffffffff), -1 )
    assert_equal( BinLib.to_uint32(0xffffffff), 4294967295 )
  end

  def test_cat
    assert_equal( BinLib.cat([0xaa, 0x55]), 0xaa55)
    assert_equal( BinLib.cat([0xaa, 0xff, 0x55]), 0xaaff55)
    assert_equal( BinLib.cat([0xaa00, 0x55]), 0xaa0055)
    assert_equal( BinLib.cat([0xaa, 0x5500]), 0xaa5500)
  end
  
  def test_split
    assert_equal( BinLib.split(0xaa55), [0xaa, 0x55])
    assert_equal( BinLib.split(0xaa0055), [0xaa, 0x0, 0x55])
  end
end
