defmodule DarnDmap.SafeTensor do
  def to_safe_list(nil), do: []

  def to_safe_list(%Nx.Tensor{} = tensor) do
    Nx.to_list(tensor)
  end

  def to_safe_list(list) when is_list(list), do: list
end
