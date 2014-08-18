defmodule Solution.Base64 do
  @doc ~S"""
  Pad the given bitstring so it becomes divisible by 'to_multiple_of' without remainder.

  ## Examples

      iex> Solution.Base64.pad_bit_length "fo", 6
      <<102, 111, 0::size(2)>>

  """
  def pad_bit_length(b, to_multiple_of) when rem(bit_size(b), to_multiple_of) == 0 do
      b
  end

  def pad_bit_length(b, to_multiple_of) do    
    current_bits = bit_size(b)
    factor = div(current_bits, to_multiple_of)  
    remainder = (to_multiple_of * factor + to_multiple_of) - current_bits

    pad_bit_length(<<b::binary, 0::size(remainder)>>, to_multiple_of)
  end


  @doc ~S"""
  Encode the input string or charlist to base64. This function always returns a string.

  ## Examples

      iex> Solution.Base64.encode_string "foo"
      "Zm9v"

      iex> Solution.Base64.encode_string 'bar'
      "YmFy"

  """
  def encode_string(input) do    
    # Convert the input to a string if it is a char list
    if is_list(input) do
      input = to_string input
    end

    # Pad the input with 0-bits so we can run the base64 algo    
    padded = pad_bit_length(input, 6)    
    base64_encode(padded, "")
  end
  
  defp base64_encode(b, acc) when bit_size(b) == 0 do
    acc
  end 

  defp base64_encode(b, acc) do
    _window = 6
    remaining_bits = bit_size(b) - _window

    if is_binary(b) do
      b = <<b::binary>>
    end

    <<codepoint::size(_window), b::size(remaining_bits)>> = b
    
    base64_encode(<<b::size(remaining_bits)>>, acc <> Map.get(Constants.base64_map, codepoint))
  end

  def decode_string(input) do    
    # Convert the input to a string if it is a char list
    if is_list(input) do
      input = to_string input
    end
    
    # Pad the input with 0-bits so we can run the base64 algo    
    base64_decode(input, <<>>)
  end

  defp base64_decode(b, acc) when bit_size(b) == 0  do
    four_characters_to_three_bytes(acc)
  end

  defp base64_decode(b, acc) do
    <<character, b::binary>> = b

    byte = Map.get(Constants.reverse_base64_map, <<character>>)
    base64_decode(b, acc <> <<byte>>)
  end

  defp four_characters_to_three_bytes(chars) do 
    _window = 8

    <<chars::size(1), rest::binary>> = <<chars::binary>>
    chars
  end
end
