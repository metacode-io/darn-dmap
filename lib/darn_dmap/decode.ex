defmodule DarnDmap.Decode do

  def decode_records(records) do
    records |> Enum.map(&decode_record/1)
  end

  def decode_record(record) do
    record
    |> Map.new(fn {key, field} ->
      {key, decode_field(field)}
    end)
    |> add_time()
  end

  defp decode_field({:scalar, {_type, value}}), do: value

  defp decode_field({:vector, {type, values}}) do
    values
    |> sanitize_vector_values(type)
    |> Nx.tensor(type: nx_type(type))
  end

  defp decode_field(other), do: other

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

  defp add_time(record) do
    dt =
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
          {record["time.us"], 6}
        ),
        "Etc/UTC"
      )

    Map.put(record, "time", dt)
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
