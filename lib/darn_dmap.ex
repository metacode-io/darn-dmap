defmodule DarnDmap do
  @moduledoc """
  Documentation for `DarnDmap`.
  """

  def read_records(path) do
    DarnDmap.Native.read_records(path)
  end
end
