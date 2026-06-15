defmodule DarnDmap.Read do
  alias DarnDmap.{Decode, Native}

  def read(_source, _ftype, opts \\ [])

  def read({:path, path}, ftype, opts), do: read(path, ftype, opts)

  def read({:bytes, bytes}, ftype, opts) do
    lax? = Keyword.get(opts, :lax?, false)
    indices = Keyword.get(opts, :indices, [])

    case {lax?, indices} do
      {false, []} ->
        Native.read_bytes(bytes, ftype)

      {true, []} ->
        Native.read_bytes_lax(bytes, ftype)

      {false, idxs} when is_list(idxs) ->
        Native.read_bytes_by_indices(bytes, ftype, idxs)

      {true, idxs} when is_list(idxs) ->
        Native.read_bytes_by_indices_lax(bytes, ftype, idxs)
    end
    |> maybe_decode(opts)
  end

  def read(path, ftype, opts) do
    lax? = Keyword.get(opts, :lax?, false)
    indices = Keyword.get(opts, :indices, [])

    case {lax?, indices} do
      {false, []} ->
        Native.read(path, ftype)

      {true, []} ->
        Native.read_lax(path, ftype)

      {false, idxs} when is_list(idxs) ->
        Native.read_by_indices(path, ftype, idxs)

      {true, idxs} when is_list(idxs) ->
        Native.read_by_indices_lax(path, ftype, idxs)
    end
    |> maybe_decode(opts)
  end

  def read_metadata(path, ftype, opts \\ [decode?: true]) do
    indices = Keyword.get(opts, :indices, [])
    case indices do
      [] ->
        Native.read_metadata(path, ftype)

      idxs when is_list(idxs) ->
        Native.read_metadata_by_indices(path, ftype, idxs)
    end
    |> maybe_decode(opts)
  end

  defp maybe_decode({records, bad_bytes}, opts) do
    {maybe_decode(records, opts), bad_bytes}
  end

  defp maybe_decode(records, opts) when is_list(records) do
    if Keyword.get(opts, :decode?, true) do
      Decode.decode_records(records)
    else
      records
    end
  end
end
