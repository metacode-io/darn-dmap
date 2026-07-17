defmodule DarnDmap.SafeTensor do
  @moduledoc """
  Utilities for constructing `Nx.Tensor` values safely.

  Tensor creation is isolated here so that `darn_dmap` can gracefully handle
  situations where `Nx` is unavailable or optional.
  """

  def to_safe_list(nil), do: []

  def to_safe_list(%Nx.Tensor{} = tensor) do
    Nx.to_list(tensor)
  end

  def to_safe_list(list) when is_list(list), do: list
end
