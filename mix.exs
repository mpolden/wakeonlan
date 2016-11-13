defmodule WOL.Mixfile do
  use Mix.Project

  def project do
    [
      app: :wakeonlan,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    []
  end

  defp deps do
    [{:socket, "~> 0.3"}]
  end

  defp package do
    [
      name: "wakeonlan",
      files: ["lib", "mix.ex", "README", "LICENSE"],
      licenses: ["BSD 3-Clause"],
      links: %{"GitHub" => "https://github.com/martinp/wakeonlan"}
    ]
  end
end
