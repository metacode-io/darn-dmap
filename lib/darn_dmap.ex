defmodule DarnDmap do
  @moduledoc """
  Documentation for `DarnDmap`.
  """

  alias DarnDmap.Read

  def read_iqdat(path, opts \\ []), do: Read.read(path, :iqdat, opts)
  def read_rawacf(path, opts \\ []), do: Read.read(path, :rawacf, opts)
  def read_fitacf(path, opts \\ []), do: Read.read(path, :fitacf, opts)
  def read_grid(path, opts \\ []), do: Read.read(path, :grid, opts)
  def read_map(path, opts \\ []), do: Read.read(path, :map, opts)
  def read_snd(path, opts \\ []), do: Read.read(path, :snd, opts)
  def read_dmap(path, opts \\ []), do: Read.read(path, :dmap, opts)

  def read_iqdat_lax(path, opts \\ []), do: Read.read_lax(path, :iqdat, opts)
  def read_rawacf_lax(path, opts \\ []), do: Read.read_lax(path, :rawacf, opts)
  def read_fitacf_lax(path, opts \\ []), do: Read.read_lax(path, :fitacf, opts)
  def read_grid_lax(path, opts \\ []), do: Read.read_lax(path, :grid, opts)
  def read_map_lax(path, opts \\ []), do: Read.read_lax(path, :map, opts)
  def read_snd_lax(path, opts \\ []), do: Read.read_lax(path, :snd, opts)
  def read_dmap_lax(path, opts \\ []), do: Read.read_lax(path, :dmap, opts)

  def read_iqdat_bytes(path, opts \\ []), do: Read.read_bytes(path, :iqdat, opts)
  def read_rawacf_bytes(path, opts \\ []), do: Read.read_bytes(path, :rawacf, opts)
  def read_fitacf_bytes(path, opts \\ []), do: Read.read_bytes(path, :fitacf, opts)
  def read_grid_bytes(path, opts \\ []), do: Read.read_bytes(path, :grid, opts)
  def read_map_bytes(path, opts \\ []), do: Read.read_bytes(path, :map, opts)
  def read_snd_bytes(path, opts \\ []), do: Read.read_bytes(path, :snd, opts)
  def read_dmap_bytes(path, opts \\ []), do: Read.read_bytes(path, :dmap, opts)

  def read_iqdat_bytes_lax(path, opts \\ []), do: Read.read_bytes_lax(path, :iqdat, opts)
  def read_rawacf_bytes_lax(path, opts \\ []), do: Read.read_bytes_lax(path, :rawacf, opts)
  def read_fitacf_bytes_lax(path, opts \\ []), do: Read.read_bytes_lax(path, :fitacf, opts)
  def read_grid_bytes_lax(path, opts \\ []), do: Read.read_bytes_lax(path, :grid, opts)
  def read_map_bytes_lax(path, opts \\ []), do: Read.read_bytes_lax(path, :map, opts)
  def read_snd_bytes_lax(path, opts \\ []), do: Read.read_bytes_lax(path, :snd, opts)
  def read_dmap_bytes_lax(path, opts \\ []), do: Read.read_bytes_lax(path, :dmap, opts)

  def peek_iqdat(path, opts \\ []), do: Read.peek(path, :iqdat, opts)
  def peek_rawacf(path, opts \\ []), do: Read.peek(path, :rawacf, opts)
  def peek_fitacf(path, opts \\ []), do: Read.peek(path, :fitacf, opts)
  def peek_grid(path, opts \\ []), do: Read.peek(path, :grid, opts)
  def peek_map(path, opts \\ []), do: Read.peek(path, :map, opts)
  def peek_snd(path, opts \\ []), do: Read.peek(path, :snd, opts)
  def peek_dmap(path, opts \\ []), do: Read.peek(path, :dmap, opts)

  def read_iqdat_metadata(path, opts \\ [raw: true]), do: Read.read_metadata(path, :iqdat, opts)
  def read_rawacf_metadata(path, opts \\ [raw: true]), do: Read.read_metadata(path, :rawacf, opts)
  def read_fitacf_metadata(path, opts \\ [raw: true]), do: Read.read_metadata(path, :fitacf, opts)
  def read_grid_metadata(path, opts \\ [raw: true]), do: Read.read_metadata(path, :grid, opts)
  def read_map_metadata(path, opts \\ [raw: true]), do: Read.read_metadata(path, :map, opts)
  def read_snd_metadata(path, opts \\ [raw: true]), do: Read.read_metadata(path, :snd, opts)
  def read_dmap_metadata(path, opts \\ [raw: true]), do: Read.read_metadata(path, :dmap, opts)

end
