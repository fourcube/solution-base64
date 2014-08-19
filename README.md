solution-base64
===============

Mix module providing base64 encoding and decoding for Elixir. It provides the functions `encode_base64` and `decode_base64`. They work on strings and char lists but always return a string.

Usage
-----

First include add it to your projects dependencies:

```
# mix.exs

defp deps do
  [     
    {:solution_base64, github: "fourcube/solution-base64"}     
  ]
end
```

Then import it inside your module:

```
defmodule MyModule do
  import Solution.Base64

  #...
  def get_me_foo do
    a = encode_base64 "foo"

    decode_base64 a
  end
end


