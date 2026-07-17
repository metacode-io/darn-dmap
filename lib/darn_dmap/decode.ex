defmodule DarnDmap.Decode do
  alias DarnDmap.DmapError

  @type decode_mode :: :elixir | :nx | :raw

  def decode_records!(records, opts \\ []) do
    decode_mode = Keyword.get(opts, :decode_mode, :elixir)

    if decode_mode == :raw do
      records
    else
      records |> Enum.map(&do_decode_record!(&1, decode_mode))
    end
  end

  defp do_decode_record!(record, decode_mode) do
    record
    |> Map.new(fn {key, field} ->
      {key, decode_field!(field, decode_mode)}
    end)
    |> maybe_add_time!()
  end

  defp decode_field!({:scalar, {_type, value}}, _decode_mode), do: value

  defp decode_field!({:vector, {type, values}}, :nx) do
    values
    |> sanitize_vector_values(type)
    |> Nx.tensor(type: nx_type(type))
  end

  defp decode_field!({:vector, {type, values}}, :elixir) do
    values |> sanitize_vector_values(type)
  end

  defp decode_field!(_field, _decode_mode) do
    raise DmapError, message: "unknown field type"
  end

  defp nx_type(:char), do: {:s, 8}
  defp nx_type(:short), do: {:s, 16}
  defp nx_type(:int), do: {:s, 32}
  defp nx_type(:long), do: {:s, 64}
  defp nx_type(:uchar), do: {:u, 8}
  defp nx_type(:ushort), do: {:u, 16}
  defp nx_type(:uint), do: {:u, 32}
  defp nx_type(:ulong), do: {:u, 64}
  defp nx_type(:float), do: {:f, 32}
  defp nx_type(:double), do: {:f, 64}
  defp nx_type(type), do: type

  defp maybe_add_time!(record) do
    required_keys =
      ~w(
        time.yr
        time.mo
        time.dy
        time.hr
        time.mt
        time.sc
      )

    if Enum.all?(required_keys, &Map.has_key?(record, &1)) do
      Map.put(record, "time", build_time!(record))
    else
      record
    end
  end

  defp build_time!(record) do
    DateTime.new!(
      Date.new!(
        record["time.yr"],
        record["time.mo"],
        record["time.dy"]
      ),
      Time.new!(
        record["time.hr"],
        record["time.mt"],
        record["time.sc"],
        {Map.get(record, "time.us", 0), 6}
      ),
      "Etc/UTC"
    )
  end

  defp sanitize_vector_values(values, type) when type in [:float, :double] do
    values
    |> Enum.map(fn
      nil -> :nan
      value -> value
    end)
  end

  defp sanitize_vector_values(values, _type), do: values
end
