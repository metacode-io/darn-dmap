defmodule DarnDmap do
  @moduledoc """
  Documentation for `DarnDmap`.
  """

  alias DarnDmap.Native

  def read(path, :iqdat), do: Native.read_iqdat(path)
  def read(path, :rawacf), do: Native.read_rawacf(path)
  def read(path, :fitacf), do: Native.read_fitacf(path)
  def read(path, :grid), do: Native.read_grid(path)
  def read(path, :map), do: Native.read_map(path)
  def read(path, :snd), do: Native.read_snd(path)
  def read(path, :dmap), do: Native.read_dmap(path)

  def read_lax(path, :iqdat), do: Native.read_iqdat_lax(path)
  def read_lax(path, :rawacf), do: Native.read_rawacf_lax(path)
  def read_lax(path, :fitacf), do: Native.read_fitacf_lax(path)
  def read_lax(path, :grid), do: Native.read_grid_lax(path)
  def read_lax(path, :map), do: Native.read_map_lax(path)
  def read_lax(path, :snd), do: Native.read_snd_lax(path)
  def read_lax(path, :dmap), do: Native.read_dmap_lax(path)

  def read_bytes(bytes, :iqdat), do: Native.read_iqdat_bytes(bytes)
  def read_bytes(bytes, :rawacf), do: Native.read_rawacf_bytes(bytes)
  def read_bytes(bytes, :fitacf), do: Native.read_fitacf_bytes(bytes)
  def read_bytes(bytes, :grid), do: Native.read_grid_bytes(bytes)
  def read_bytes(bytes, :map), do: Native.read_map_bytes(bytes)
  def read_bytes(bytes, :snd), do: Native.read_snd_bytes(bytes)
  def read_bytes(bytes, :dmap), do: Native.read_dmap_bytes(bytes)

  def read_bytes_lax(bytes, :iqdat), do: Native.read_iqdat_bytes_lax(bytes)
  def read_bytes_lax(bytes, :rawacf), do: Native.read_rawacf_bytes_lax(bytes)
  def read_bytes_lax(bytes, :fitacf), do: Native.read_fitacf_bytes_lax(bytes)
  def read_bytes_lax(bytes, :grid), do: Native.read_grid_bytes_lax(bytes)
  def read_bytes_lax(bytes, :map), do: Native.read_map_bytes_lax(bytes)
  def read_bytes_lax(bytes, :snd), do: Native.read_snd_bytes_lax(bytes)
  def read_bytes_lax(bytes, :dmap), do: Native.read_dmap_bytes_lax(bytes)

  def peek(path, :iqdat), do: Native.peek_iqdat(path)
  def peek(path, :rawacf), do: Native.peek_rawacf(path)
  def peek(path, :fitacf), do: Native.peek_fitacf(path)
  def peek(path, :grid), do: Native.peek_grid(path)
  def peek(path, :map), do: Native.peek_map(path)
  def peek(path, :snd), do: Native.peek_snd(path)
  def peek(path, :dmap), do: Native.peek_dmap(path)

  def read_metadata(path, :iqdat), do: Native.read_iqdat_metadata(path)
  def read_metadata(path, :rawacf), do: Native.read_rawacf_metadata(path)
  def read_metadata(path, :fitacf), do: Native.read_fitacf_metadata(path)
  def read_metadata(path, :grid), do: Native.read_grid_metadata(path)
  def read_metadata(path, :map), do: Native.read_map_metadata(path)
  def read_metadata(path, :snd), do: Native.read_snd_metadata(path)
  def read_metadata(path, :dmap), do: Native.read_dmap_metadata(path)
end
