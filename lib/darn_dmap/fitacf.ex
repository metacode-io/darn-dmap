defmodule DarnDmap.Fitacf do
  alias Explorer.DataFrame, as: DF
  import DarnDmap.SafeTensor, only: [to_safe_list: 1]

  def to_dataframe(records) when is_list(records) do
    records
    |> to_rows()
    |> DF.new()
  end

  def to_rows(records) when is_list (records) do
    records
    |> Enum.flat_map(&record_to_rows/1)
  end

  def record_to_rows(record) do
    gates = to_safe_list(record["slist"])
    velocities = to_safe_list(record["v"])
    gscatter = to_safe_list(record["gflg"])
    powers = to_safe_list(record["p_l"])
    widths = to_safe_list(record["w_l"])

    [
      gates,
      velocities,
      gscatter,
      powers,
      widths
    ]
    |> Enum.zip()
    |> Enum.map(fn {rg, v, gs, p, w} ->
      %{
        time: record["time"],           # synthesized DateTime
        stid: record["stid"],           # station/radar id
        beam: record["bmnum"],          # beam number
        azimuth: record["bmazm"],       # beam azimuth
        scan: record["scan"],           # scan flag
        channel: record["channel"],     # stereo / channel info
        sky_noise: record["noise.sky"], # sky noise
        tfreq: record["tfreq"],         # transmit frequency
        num_gates: record["nrang"],     # number of range gates
        first_range: record["frang"],   # first range distance
        range_sep: record["rsep"],      # range separation
        cp: record["cp"],               # control program id
        gate: rg,
        velocity: v,
        groundscatter: gs == 1,
        power: p,
        width: w
      }
    end)
  end
end
