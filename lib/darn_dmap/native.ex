defmodule DarnDmap.Native do
  import DarnDmap.Native.ReadNif

  use Rustler,
    otp_app: :darn_dmap,
    crate: :darn_dmap_nif

  read_nif(:iqdat)
  read_nif(:rawacf)
  read_nif(:fitacf)
  read_nif(:grid)
  read_nif(:map)
  read_nif(:snd)
  read_nif(:dmap)
end
