defmodule DarnDmap.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/metacode-io/darn-dmap"

  def project do
    [
      app: :darn_dmap,
      version: @version,
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "Elixir bindings for reading SuperDARN DMAP data."
  end

  defp package do
    [
      licenses: ["LGPL-3.0-or-later"],
      maintainers: ["Matt Caldwell"],
      links: %{
        "Github" => @source_url,
        "SuperDARN" => "https://superdarn.org"
      },
      files: [
        "lib",
        "native",
        "mix.exs",
        "README.md",
        "LICENSE",
        "Cargo.toml",
        "Cargo.lock",
        ".formatter.exs"
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.36"},
      {:nx, "~> 0.12"},
      {:ex_doc, "~> 0.40", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs do
    [
      main: "DarnDmap",
      extras: ["README.md"]
    ]
  end
end
