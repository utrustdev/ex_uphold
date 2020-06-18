defmodule ExUphold.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_uphold,
      version: "0.0.3",
      elixir: "~> 1.8",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:jason, "~> 1.1"},
      {:exvcr, "~> 0.11.0", only: :test},
      {:hackney, "~> 1.15"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Elixir client for Uphold API
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/utrustdev/ex_uphold"}
    ]
  end
end
