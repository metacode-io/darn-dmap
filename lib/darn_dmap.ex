defmodule DarnDmap do
  @moduledoc """
  Documentation for `DarnDmap`.
  """

  alias DarnDmap.Read

  defdelegate read(source, ftype, opts \\ []), to: Read

  defdelegate read!(source, ftype, opts \\ []), to: Read

  defdelegate read_metadata(path, ftype, opts \\ []), to: Read
  defdelegate read_metadata!(path, ftype, opts \\ []), to: Read

end
