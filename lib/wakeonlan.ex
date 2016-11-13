defmodule WOL do
  @moduledoc """
  A module for sending Wake-on-LAN packets.
  """

  @doc """
  Converts the given `mac_addr` into a binary. Hexadecimals can be mixed case,
  and valid separators are hyphen (-) and colon (:).

  ## Examples

      iex> WOL.mac_to_binary("12:34:56:AB:CD:EF")
      <<18, 52, 86, 171, 205, 239>>

      iex> WOL.mac_to_binary("12-34-56-AB-CD-EF")
      <<18, 52, 86, 171, 205, 239>>

      iex> WOL.mac_to_binary("12-34-56-ab-cd-ef")
      <<18, 52, 86, 171, 205, 239>>
  """
  def mac_to_binary(mac_addr) do
    String.upcase(mac_addr) |>
      String.split([":", "-"], parts: 6) |>
      Stream.map(&Base.decode16!/1) |>
      Enum.to_list |>
      IO.iodata_to_binary
  end

  @doc """
  Creates a magic packet for the given `mac_addr`.

  ## Examples

      iex> magic_packet = WOL.magic_packet("12:34:56:ab:cd:ef")
      iex> is_binary(magic_packet)
      true
      iex> byte_size(magic_packet)
      102
  """
  def magic_packet(mac_addr) do
    broadcast = <<255, 255, 255, 255, 255, 255>>
    mac = mac_to_binary(mac_addr)
    [broadcast | List.duplicate(mac, 16)] |> IO.iodata_to_binary
  end

  @doc """
  Send magic packet to the given `mac_addr`. By default, the packet is sent to
  the broadcast address 255.255.255.255 (current nework) and UDP port 9
  (discard).

  Returns `:ok`.

  ## Examples

      iex> WOL.send("12:34:56:ab:cd:ef")
      :ok

      iex> WOL.send("12:34:56:ab:cd:ef", broadcast_addr: "192.168.0.255", port: 7)
      :ok
  """
  def send(mac_addr, opts \\ []) do
    addr = Keyword.get(opts, :broadcast_addr, "255.255.255.255")
    port = Keyword.get(opts, :port, 9)
    data = magic_packet(mac_addr)
    Socket.UDP.open!(broadcast: true) |>
      Socket.Datagram.send(data, {addr, port})
  end
end
