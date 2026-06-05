defmodule DarnDmap do
  @moduledoc """
  Documentation for `DarnDmap`.
  """

  def count_records(path) do
    DarnDmap.Native.count_records(path)
  end

  def first_record_keys(path) do
    DarnDmap.Native.first_record_keys(path)
  end

  def first_record(path) do
    DarnDmap.Native.first_record(path)
  end

  # def first_record_debug(path) do
  #   DarnDmap.Native.first_record_debug(path)
  # end
end
