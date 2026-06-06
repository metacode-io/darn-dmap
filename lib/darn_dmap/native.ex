defmodule DarnDmap.Native do
  use Rustler,
    otp_app: :darn_dmap,
    crate: :darn_dmap_nif

  def read_iqdat(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_iqdat_lax(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_iqdat_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def read_iqdat_bytes_lax(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def peek_iqdat(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_iqdat_metadata(_path), do: :erlang.nif_error(:nif_not_loaded)

  def read_rawacf(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_rawacf_lax(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_rawacf_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def read_rawacf_bytes_lax(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def peek_rawacf(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_rawacf_metadata(_path), do: :erlang.nif_error(:nif_not_loaded)

  def read_fitacf(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_fitacf_lax(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_fitacf_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def read_fitacf_bytes_lax(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def peek_fitacf(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_fitacf_metadata(_path), do: :erlang.nif_error(:nif_not_loaded)

  def read_grid(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_grid_lax(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_grid_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def read_grid_bytes_lax(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def peek_grid(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_grid_metadata(_path), do: :erlang.nif_error(:nif_not_loaded)

  def read_map(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_map_lax(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_map_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def read_map_bytes_lax(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def peek_map(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_map_metadata(_path), do: :erlang.nif_error(:nif_not_loaded)

  def read_snd(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_snd_lax(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_snd_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def read_snd_bytes_lax(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def peek_snd(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_snd_metadata(_path), do: :erlang.nif_error(:nif_not_loaded)

  def read_dmap(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_dmap_lax(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_dmap_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def read_dmap_bytes_lax(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def peek_dmap(_path), do: :erlang.nif_error(:nif_not_loaded)
  def read_dmap_metadata(_path), do: :erlang.nif_error(:nif_not_loaded)
end
