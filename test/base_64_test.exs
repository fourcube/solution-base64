defmodule Solution.Base64Test do
  use ExUnit.Case
  doctest Solution.Base64
  import Solution.Base64

  test "pad_bits - size is ok" do
    padded = pad_bits(<<0, 0, 0, 1>>, 6)
    assert bit_size(padded) == 36
  end

  test "pad_bits - needs padding" do
    padded = pad_bits(<<1, 1>>, 6)

    # Check the correct size
    assert bit_size(padded) == 18
    # Check the correct value
    assert padded == <<1,1, 0::1, 0::1>>
  end

  test "pad_bits - pad string" do
    padded = pad_bits("ab", 6)
    
    # Check the correct size
    assert bit_size(padded) == 18
    # Check the correct value
    assert padded == <<97, 98, 0::1, 0::1>>
  end

  test "encode string to base64" do
    assert "Zm9v" == encode_base64 "foo"
  end

  test "encode string to base64 - empty" do
    assert "" == encode_base64 ""
  end

  test "encode binary to base64 - 'b'" do
    assert "Yg" == encode_base64 <<98>>
  end

  test "encode string to base64 - unicode" do 
    assert "xYI" == encode_base64 "ł"
  end

  test "encode charlist to base64" do 
    assert "Zm9v" == encode_base64 'foo'
  end  

  test "decode base64 string - no padding" do 
    assert "foo" == decode_base64 "Zm9v"
  end

  test "decode base64 string" do 
    assert "b" == decode_base64 "Yg"
  end

  test "decode base64 binary" do 
    assert "foo" == decode_base64 <<90, 109, 57, 118>>
  end

  test "decode base64 string - unicode" do
    assert "ł" = decode_base64 "xYI"
  end

  test "encode and decode lorem ipsum" do
    input = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    encoded = encode_base64 input
    decoded = decode_base64 encoded

    assert decoded == input
  end
end
