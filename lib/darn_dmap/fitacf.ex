defmodule DarnDmap.Fitacf do
  alias Explorer.DataFrame, as: DF
  import DarnDmap.SafeTensor, only: [to_safe_list: 1]

  def to_dataframe(records) when is_list(records) do
    records
    |> to_rows()
    |> DF.new()
  end

  def to_rows(records) when is_list(records) do
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
        # synthesized DateTime
        time: record["time"],
        # station/radar id
        stid: record["stid"],
        # beam number
        beam: record["bmnum"],
        # beam azimuth
        azimuth: record["bmazm"],
        # scan flag
        scan: record["scan"],
        # stereo / channel info
        channel: record["channel"],
        # sky noise
        sky_noise: record["noise.sky"],
        # transmit frequency
        tfreq: record["tfreq"],
        # number of range gates
        num_gates: record["nrang"],
        # first range distance
        first_range: record["frang"],
        # range separation
        range_sep: record["rsep"],
        # control program id
        cp: record["cp"],
        gate: rg,
        velocity: v,
        groundscatter: gs == 1,
        power: p,
        width: w
      }
    end)
  end
end
