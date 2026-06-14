defmodule DarnDmap do
  @moduledoc """
  Documentation for `DarnDmap`.
  """

  alias DarnDmap.Read

  defdelegate read(path, ftype, opts \\ []), to: Read
  defdelegate read_lax(path, ftype, opts \\ []), to: Read
  defdelegate read_bytes(bytes, ftype, opts \\ []), to: Read
  defdelegate read_bytes_lax(bytes, ftype, opts \\ []), to: Read
  defdelegate read_by_indices(path, ftype, indices, opts \\ []), to: Read
  defdelegate read_by_indices_lax(path, ftype, indices, opts \\ []), to: Read
  defdelegate read_bytes_by_indices(bytes, ftype, indices, opts \\ []), to: Read
  defdelegate read_bytes_by_indices_lax(bytes, ftype, indices, opts \\ []), to: Read
  defdelegate read_metadata(path, ftype, opts \\ []), to: Read
  defdelegate read_metadata_by_indices(path, ftype, indices, opts \\ []), to: Read

end
