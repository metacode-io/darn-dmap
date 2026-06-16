defmodule DarnDmap.Read do
  alias DarnDmap.{Decode, DmapError, Native}

  def read(source, ftype, opts \\ []) do
    {:ok, read!(source, ftype, opts)}
  rescue
    e in DmapError ->
      {:error, e.reason}

    e ->
      {:error, e}
  end

  def read!(source, ftype, opts \\ [])

  def read!({:path, path}, ftype, opts), do: read!(path, ftype, opts)

  def read!({:bytes, bytes}, ftype, opts) when is_binary(bytes) do
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
    |> decode_read_result!(opts)
  end

  def read!(path, ftype, opts) when is_binary(path) do
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
    |> decode_read_result!(opts)
  end

  def read_metadata(path, ftype, opts \\ [decode_mode: :raw]) when is_binary(path) do
    {:ok, read_metadata!(path, ftype, opts)}
  rescue
    e in DmapError ->
      {:error, e.reason}

    e ->
      {:error, e}
  end

  def read_metadata!(path, ftype, opts \\ [decode_mode: :raw]) when is_binary(path) do
    indices = Keyword.get(opts, :indices, [])
    case indices do
      [] ->
        Native.read_metadata(path, ftype)

      idxs when is_list(idxs) ->
        Native.read_metadata_by_indices(path, ftype, idxs)
    end
    |> decode_read_result!(opts)
  end

  defp decode_read_result!({records, bad_byte}, opts) do
    records = Decode.decode_records!(records, opts)

    case bad_byte do
      nil -> records
      byte -> {records, [bad_byte: byte]}
    end
  end

  defp decode_read_result!(records, opts) when is_list(records) do
    Decode.decode_records!(records, opts)
  end
end
