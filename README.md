# wakeonlan

An [Elixir](http://elixir-lang.org) module for sending Wake-on-LAN packets.

## Installation

  1. Add `wakeonlan` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:wakeonlan, "~> 0.1.0"}]
    end
    ```

  2. Run `mix deps.get` to install.

## Examples

Creating a magic packet:

```
iex> magic_packet = WOL.magic_packet("12:34:56:ab:cd:ef")
iex> is_binary(magic_packet)
true
iex> byte_size(magic_packet)
102
```

Sending a magic packet:

```
iex> WOL.send("12:34:56:ab:cd:ef")
:ok
```
