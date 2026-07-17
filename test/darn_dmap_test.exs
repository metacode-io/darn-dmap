defmodule DarnDmapTest do
  use ExUnit.Case
  doctest DarnDmap

  @formats [:iqdat, :rawacf, :fitacf, :grid, :map, :snd]
  @fixtures Path.expand("fixtures", __DIR__)

  for format <- @formats do
    @format format

    test "reads #{format} records from a path" do
      path = fixture_path(@format)

      assert {:ok, records} = DarnDmap.read(path, @format)
      assert length(records) == 2
      assert Enum.all?(records, &is_map/1)
    end

    test "reads #{format} records from bytes identically to a path" do
      path = fixture_path(@format)
      bytes = File.read!(path)

      assert {:ok, from_path} = DarnDmap.read(path, @format)
      assert {:ok, from_bytes} = DarnDmap.read({:bytes, bytes}, @format)

      assert from_bytes == from_path
    end

    test "reads compressed #{format} records identically to uncompressed records" do
      path = fixture_path(@format)
      compressed_path = path <> ".bz2"

      assert {:ok, uncompressed} = DarnDmap.read(path, @format)
      assert {:ok, compressed} = DarnDmap.read(compressed_path, @format)

      assert compressed == uncompressed
    end

    test "reads selected #{format} records by index" do
      path = fixture_path(@format)

      assert {:ok, all_records} = DarnDmap.read(path, @format)

      assert {:ok, first_record} =
               DarnDmap.read(path, @format, indices: [0])

      assert first_record == [hd(all_records)]
    end

    test "reads #{format} metadata by index" do
      path = fixture_path(@format)

      assert {:ok, metadata} =
               DarnDmap.read_metadata(
                 path,
                 @format,
                 indices: [0]
               )

      assert length(metadata) == 1
      assert is_map(hd(metadata))
    end
  end

  test "strict reads reject trailing invalid DMAP data" do
    path = fixture_path(:fitacf)
    corrupted = File.read!(path) <> "this is not valid DMAP data"

    assert {:error, _reason} =
             DarnDmap.read(
               {:bytes, corrupted},
               :fitacf
             )
  end

  test "lax reads preserve valid records and report the bad byte" do
    path = fixture_path(:fitacf)
    valid_bytes = File.read!(path)
    corrupted = valid_bytes <> "this is not valid DMAP data"

    assert {:ok, valid_records} =
             DarnDmap.read(
               {:bytes, valid_bytes},
               :fitacf
             )

    assert {:ok, {lax_records, bad_byte: bad_byte}} =
             DarnDmap.read(
               {:bytes, corrupted},
               :fitacf,
               lax?: true
             )

    assert lax_records == valid_records
    assert bad_byte == byte_size(valid_bytes)
  end

  test "returns an error for an out-of-bounds index" do
    path = fixture_path(:fitacf)

    assert {:ok, records} = DarnDmap.read(path, :fitacf)

    assert {:error, _reason} =
             DarnDmap.read(
               path,
               :fitacf,
               indices: [length(records)]
             )
  end

  defp fixture_path(format) do
    Path.join(@fixtures, "test.#{format}")
  end
end
