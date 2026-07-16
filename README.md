# DarnDmap

Elixir bindings for reading SuperDARN DMAP data using the Rust
[`darn-dmap`](https://crates.io/crates/darn-dmap) library.

> **Status:** Early `0.1.x` release. The public API may evolve as the library matures.

## Features

- Read SuperDARN DMAP files from disk or memory
- Supports FITACF, RAWACF, IQDAT, GRID, MAP, SND, and generic DMAP records
- Supports indexed reads for efficient random access
- Decode vectors as Elixir lists, `Nx.Tensor` values, or raw tagged fields
- Native Rust implementation via Rustler

## Requirements

`darn_dmap` includes a Rustler NIF.

Building the library from source requires a working Rust toolchain. Once
compiled, applications using `darn_dmap` do not require Rust at runtime.

## Installation

Add `darn_dmap` to your dependencies:

```elixir
def deps do
  [
    {:darn_dmap, "~> 0.1.0"}
  ]
end
```

Then fetch dependencies:

```bash
mix deps.get
```

## Usage

Read all records from a FITACF file:

```elixir
{:ok, records} =
  DarnDmap.read(
    "/path/to/file.fitacf",
    :fitacf
  )
```

The explicit path source form is also supported:

```elixir
{:ok, records} =
  DarnDmap.read(
    {:path, "/path/to/file.fitacf"},
    :fitacf
  )
```

Read records directly from bytes:

```elixir
bytes = File.read!("/path/to/file.fitacf")

{:ok, records} =
  DarnDmap.read(
    {:bytes, bytes},
    :fitacf
  )
```

Use the raising variant when failure should raise:

```elixir
records =
  DarnDmap.read!(
    "/path/to/file.fitacf",
    :fitacf
  )
```

Read selected records by zero-based index:

```elixir
{:ok, records} =
  DarnDmap.read(
    "/path/to/file.fitacf",
    :fitacf,
    indices: [0, 10, 25]
  )
```

Decode vector fields as `Nx.Tensor` values:

```elixir
{:ok, records} =
  DarnDmap.read(
    "/path/to/file.fitacf",
    :fitacf,
    decode_mode: :nx
  )
```

Return the raw tagged DMAP representation:

```elixir
{:ok, records} =
  DarnDmap.read(
    "/path/to/file.fitacf",
    :fitacf,
    decode_mode: :raw
  )
```

Perform a lax read and report the first unreadable byte position:

```elixir
{:ok, {records, bad_byte: byte_offset}} =
  DarnDmap.read(
    "/path/to/file.fitacf",
    :fitacf,
    lax?: true
  )
```

When no unreadable byte is encountered, a lax read returns the records directly:

```elixir
{:ok, records} =
  DarnDmap.read(
    "/path/to/file.fitacf",
    :fitacf,
    lax?: true
  )
```

Supported record types are:

```elixir
:iqdat
:rawacf
:fitacf
:grid
:map
:snd
:dmap
```

## License

Licensed under the GNU Lesser General Public License v3.0 or later.

See the [LICENSE](LICENSE) file for details.