defmodule WOLTest do
  use ExUnit.Case
  doctest WOL

  test "mac to binary" do
    assert WOL.mac_to_binary("FF:FF:FF:FF:FF:FF") == <<255, 255, 255, 255, 255, 255>>
    assert WOL.mac_to_binary("ff-ff-ff-ff-ff-ff") == <<255, 255, 255, 255, 255, 255>>
  end

  test "magic packet" do
    magic_packet = WOL.magic_packet("65:ac:81:13:8d:3f")
    assert magic_packet == <<255, 255, 255, 255, 255, 255,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63,
      101, 172, 129, 19, 141, 63>>
  end
end
