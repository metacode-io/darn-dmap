defmodule DarnDmap.Read do
  alias DarnDmap.{Decode, Native}

  def read(path, ftype, opts \\ []) do
    path
    |> Native.read(ftype)
    |> maybe_decode(opts)
  end

  def read_lax(path, ftype, opts \\ []) do
    path
    |> Native.read_lax(ftype)
    |> maybe_decode(opts)
  end

  def read_bytes(bytes, ftype, opts \\ []) do
    bytes
    |> Native.read_bytes(ftype)
    |> maybe_decode(opts)
  end

  def read_bytes_lax(bytes, ftype, opts \\ []) do
    bytes
    |> Native.read_bytes_lax(ftype)
    |> maybe_decode(opts)
  end

  def read_by_indices(path, ftype, indices, opts \\ []) do
    path
    |> Native.read_by_indices(ftype, indices)
    |> maybe_decode(opts)
  end

  def read_by_indices_lax(path, ftype, indices, opts \\ []) do
    path
    |> Native.read_by_indices_lax(ftype, indices)
    |> maybe_decode(opts)
  end

  def read_bytes_by_indices(bytes, ftype, indices, opts \\ []) do
    bytes
    |> Native.read_bytes_by_indices(ftype, indices)
    |> maybe_decode(opts)
  end

  def read_bytes_by_indices_lax(bytes, ftype, indices, opts \\ []) do
    bytes
    |> Native.read_bytes_by_indices_lax(ftype, indices)
    |> maybe_decode(opts)
  end

  def read_metadata(path, ftype, opts \\ [decode: false]) do
    path
    |> Native.read_metadata(ftype)
    |> maybe_decode(opts)
  end

  def read_metadata_by_indices(path, ftype, indices, opts \\ [decode: false]) do
    path
    |> Native.read_metadata_by_indices(ftype, indices)
    |> maybe_decode(opts)
  end

  defp maybe_decode(records, opts) do
    if Keyword.get(opts, :decode, false) do
      records
    else
      Decode.decode_records(records)
    end
  end
end
