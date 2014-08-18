defmodule Solution.Base64Test do
  use ExUnit.Case
  doctest Solution.Base64
  import Solution.Base64

  test "pad_bit_length - size is ok" do
    padded = pad_bit_length(<<0, 0, 0, 1>>, 6)
    assert bit_size(padded) == 36
  end

  test "pad_bit_length - needs padding" do
    padded = pad_bit_length(<<1, 1>>, 6)

    # Check the correct size
    assert bit_size(padded) == 18
    # Check the correct value
    assert padded == <<1,1, 0::1, 0::1>>
  end

  test "pad_bit_length - pad string" do
    padded = pad_bit_length("ab", 6)
    
    # Check the correct size
    assert bit_size(padded) == 18
    # Check the correct value
    assert padded == <<97, 98, 0::1, 0::1>>
  end

  test "pad_bit_length - pad string" do
    padded = pad_bit_length("ab", 6)
    
    # Check the correct size
    assert bit_size(padded) == 18
    # Check the correct value
    assert padded == <<97, 98, 0::1, 0::1>>
  end

  test "encode string to base64" do
    assert "Zm9v" == encode_string "foo"
  end

  test "encode string to base64 - empty" do
    assert "" == encode_string ""
  end

  test "encode string to base64 - 'b'" do
    assert "Yg" == encode_string <<98>>
  end

  test "encode string to base64 - unicode" do 
    assert "xYI" == encode_string "ł"
  end

  test "encode charlist to base64" do 
    assert "Zm9v" == encode_string 'foo'
  end

  test "decode base64 string" do 
    assert "foo" == decode_string "Zm9v"
  end
end
