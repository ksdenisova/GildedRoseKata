defmodule GildedRose.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gilded_rose,
      version: "0.0.1",
      elixir: "~> 1.13",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:mix_test_watch, "~>1.0", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_parameterized, "~> 1.3.7"}
    ]
  end
end
