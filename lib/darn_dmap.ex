defmodule DarnDmap do
  @moduledoc """
  Reads SuperDARN DMAP records from filesl or in-memory binaries.

  Supported record types are:

    * `:iqdat`
    * `:rawacf`
    * `:fitacf`
    * `:grid`
    * `:map`
    * `:snd`
    * `:dmap`

  Records are decoded into Elixir maps by default. Vector fields may instead
  be returned as `Nx.Tensor` values with `decode_mode: :nx`, or left in their
  raw tagged representation with `decode_mode: :raw`.

  ## Examples

      {:ok, records} =
        DarnDmap.read("/path/to/20150505.2201.bks.fitacf3.bz2", :fitacf)

      {:ok, records} =
        DarnDmap.read(
          {:bytes, File.read!("/path/to/20150505.2201.bks.fitacf3.bz2")},
          :fitacf,
          indices: [0, 10]
        )

      records =
        DarnDmap.read!(
          "/path/to/20150505.2201.bks.fitacf3.bz2",
          :fitacf,
          decode_mode: :nx
        )
  """

  alias DarnDmap.Read

  @doc """
  Reads DMAP records from a file path or binary source.

  `source` may be a path string, `{:path, path}`, or `{:bytes, binary}`.

  ## Options

        * `:indices` — zero-based record indices to read. Defaults to all records.
        * `:lax?` — when `true`, returns successfully decoded records up to the
          first unreadable byte. Defaults to `false`.
        * `:decode_mode` — one of `:elixir`, `:nx`, or `:raw`.
          Defaults to `:elixir`.

  Returns `{:ok, records}` on success or `{:error, reason}` on failure.

  A lax read that encounters unreadable data returns:

        `{:ok, {records, bad_byte: byte_offset}}`
  """
  defdelegate read(source, ftype, opts \\ []), to: Read

  @doc """
  Reads DMAP records like `read/3`, but raises on failure.
  """
  defdelegate read!(source, ftype, opts \\ []), to: Read

  @doc """
  Reads record metadata from a DMAP file.

  Metadata reads currently accept a file path rather than an in-memory binary.

  The `:indices` option may be used to select zero-based record indices.
  Metadata is returned in raw mode by default.
  """
  defdelegate read_metadata(path, ftype, opts \\ [decode_mode: :raw]), to: Read

  @doc """
  Reads record metadata like `read_metadata/3`, but raises on failure.
  """
  defdelegate read_metadata!(path, ftype, opts \\ [decode_mode: :raw]), to: Read
end
