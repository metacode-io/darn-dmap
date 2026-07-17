defmodule DarnDmap.DmapError do
  defexception [:reason]

  def message(%__MODULE__{reason: reason}) do
    "DMAP read failed: #{inspect(reason)}"
  end
end
