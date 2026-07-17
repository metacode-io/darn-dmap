defmodule DarnDmap.Native.ReadNif do
  defmacro read_nif(ftype) do
    specs = %{
      read: :"read_#{ftype}",
      read_lax: :"read_#{ftype}_lax",
      read_bytes: :"read_#{ftype}_bytes",
      read_bytes_lax: :"read_#{ftype}_bytes_lax",
      read_by_indices: :"read_#{ftype}_by_indices",
      read_by_indices_lax: :"read_#{ftype}_by_indices_lax",
      read_bytes_by_indices: :"read_#{ftype}_bytes_by_indices",
      read_bytes_by_indices_lax: :"read_#{ftype}_bytes_by_indices_lax",
      read_metadata: :"read_#{ftype}_metadata",
      read_metadata_by_indices: :"read_#{ftype}_metadata_by_indices"
    }

    quote do
      defp unquote(specs.read)(_path), do: :erlang.nif_error(:nif_not_loaded)
      defp unquote(specs.read_lax)(_path), do: :erlang.nif_error(:nif_not_loaded)
      defp unquote(specs.read_bytes)(_bytes), do: :erlang.nif_error(:nif_not_loaded)
      defp unquote(specs.read_bytes_lax)(_bytes), do: :erlang.nif_error(:nif_not_loaded)
      defp unquote(specs.read_by_indices)(_path, _indices), do: :erlang.nif_error(:nif_not_loaded)

      defp unquote(specs.read_by_indices_lax)(_path, _indices),
        do: :erlang.nif_error(:nif_not_loaded)

      defp unquote(specs.read_bytes_by_indices)(_bytes, _indices),
        do: :erlang.nif_error(:nif_not_loaded)

      defp unquote(specs.read_bytes_by_indices_lax)(_bytes, _indices),
        do: :erlang.nif_error(:nif_not_loaded)

      defp unquote(specs.read_metadata)(_path), do: :erlang.nif_error(:nif_not_loaded)

      defp unquote(specs.read_metadata_by_indices)(_path, _indices),
        do: :erlang.nif_error(:nif_not_loaded)

      def read(path, unquote(ftype)), do: unquote(specs.read)(path)
      def read_lax(path, unquote(ftype)), do: unquote(specs.read_lax)(path)
      def read_bytes(bytes, unquote(ftype)), do: unquote(specs.read_bytes)(bytes)
      def read_bytes_lax(bytes, unquote(ftype)), do: unquote(specs.read_bytes_lax)(bytes)

      def read_by_indices(path, unquote(ftype), indices),
        do: unquote(specs.read_by_indices)(path, indices)

      def read_by_indices_lax(path, unquote(ftype), indices),
        do: unquote(specs.read_by_indices_lax)(path, indices)

      def read_bytes_by_indices(bytes, unquote(ftype), indices),
        do: unquote(specs.read_bytes_by_indices)(bytes, indices)

      def read_bytes_by_indices_lax(bytes, unquote(ftype), indices),
        do: unquote(specs.read_bytes_by_indices_lax)(bytes, indices)

      def read_metadata(path, unquote(ftype)),
        do: unquote(specs.read_metadata)(path)

      def read_metadata_by_indices(path, unquote(ftype), indices),
        do: unquote(specs.read_metadata_by_indices)(path, indices)
    end
  end
end
