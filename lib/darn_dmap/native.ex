defmodule DarnDmap.Native do
  use Rustler,
    otp_app: :darn_dmap,
    crate: :darn_dmap_nif

  def read_records(_path), do: :erlang.nif_error(:nif_not_loaded)
end
