defmodule DarnDmap.Read do
  alias DarnDmap.{Decode, Native}

  def read(path, ftype, opts \\ []) do
    path
    |> native_read(ftype)
    |> maybe_decode(opts)
  end

  def read_lax(path, ftype, opts \\ []) do
    path
    |> native_read_lax(ftype)
    |> maybe_decode(opts)
  end

  def read_bytes(path, ftype, opts \\ []) do
    path
    |> native_read_bytes(ftype)
    |> maybe_decode(opts)
  end

  def read_bytes_lax(path, ftype, opts \\ []) do
    path
    |> native_read_bytes_lax(ftype)
    |> maybe_decode(opts)
  end

  def peek(path, ftype, opts \\ []) do
    path
    |> native_peek(ftype)
    |> maybe_decode(opts)
  end

  def read_metadata(path, ftype, opts \\ [raw: true]) do
    path
    |> native_read_metadata(ftype)
    |> maybe_decode(opts)
  end

  defp maybe_decode(records, opts) do
    if Keyword.get(opts, :raw, false) do
      records
    else
      Decode.decode_records(records)
    end
  end

  defp native_read(path, :iqdat), do: Native.read_iqdat(path)
  defp native_read(path, :rawacf), do: Native.read_rawacf(path)
  defp native_read(path, :fitacf), do: Native.read_fitacf(path)
  defp native_read(path, :grid), do: Native.read_grid(path)
  defp native_read(path, :map), do: Native.read_map(path)
  defp native_read(path, :snd), do: Native.read_snd(path)
  defp native_read(path, :dmap), do: Native.read_dmap(path)

  defp native_read_lax(path, :iqdat), do: Native.read_iqdat_lax(path)
  defp native_read_lax(path, :rawacf), do: Native.read_rawacf_lax(path)
  defp native_read_lax(path, :fitacf), do: Native.read_fitacf_lax(path)
  defp native_read_lax(path, :grid), do: Native.read_grid_lax(path)
  defp native_read_lax(path, :map), do: Native.read_map_lax(path)
  defp native_read_lax(path, :snd), do: Native.read_snd_lax(path)
  defp native_read_lax(path, :dmap), do: Native.read_dmap_lax(path)

  defp native_read_bytes(bytes, :iqdat), do: Native.read_iqdat_bytes(bytes)
  defp native_read_bytes(bytes, :rawacf), do: Native.read_rawacf_bytes(bytes)
  defp native_read_bytes(bytes, :fitacf), do: Native.read_fitacf_bytes(bytes)
  defp native_read_bytes(bytes, :grid), do: Native.read_grid_bytes(bytes)
  defp native_read_bytes(bytes, :map), do: Native.read_map_bytes(bytes)
  defp native_read_bytes(bytes, :snd), do: Native.read_snd_bytes(bytes)
  defp native_read_bytes(bytes, :dmap), do: Native.read_dmap_bytes(bytes)

  defp native_read_bytes_lax(bytes, :iqdat), do: Native.read_iqdat_bytes_lax(bytes)
  defp native_read_bytes_lax(bytes, :rawacf), do: Native.read_rawacf_bytes_lax(bytes)
  defp native_read_bytes_lax(bytes, :fitacf), do: Native.read_fitacf_bytes_lax(bytes)
  defp native_read_bytes_lax(bytes, :grid), do: Native.read_grid_bytes_lax(bytes)
  defp native_read_bytes_lax(bytes, :map), do: Native.read_map_bytes_lax(bytes)
  defp native_read_bytes_lax(bytes, :snd), do: Native.read_snd_bytes_lax(bytes)
  defp native_read_bytes_lax(bytes, :dmap), do: Native.read_dmap_bytes_lax(bytes)

  defp native_peek(path, :iqdat), do: Native.peek_iqdat(path)
  defp native_peek(path, :rawacf), do: Native.peek_rawacf(path)
  defp native_peek(path, :fitacf), do: Native.peek_fitacf(path)
  defp native_peek(path, :grid), do: Native.peek_grid(path)
  defp native_peek(path, :map), do: Native.peek_map(path)
  defp native_peek(path, :snd), do: Native.peek_snd(path)
  defp native_peek(path, :dmap), do: Native.peek_dmap(path)

  defp native_read_metadata(path, :iqdat), do: Native.read_iqdat_metadata(path)
  defp native_read_metadata(path, :rawacf), do: Native.read_rawacf_metadata(path)
  defp native_read_metadata(path, :fitacf), do: Native.read_fitacf_metadata(path)
  defp native_read_metadata(path, :grid), do: Native.read_grid_metadata(path)
  defp native_read_metadata(path, :map), do: Native.read_map_metadata(path)
  defp native_read_metadata(path, :snd), do: Native.read_snd_metadata(path)
  defp native_read_metadata(path, :dmap), do: Native.read_dmap_metadata(path)
end
