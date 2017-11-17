defmodule DemoDeploy.Mixfile do
  use Mix.Project

  def project do
    [
      app: :demo_deploy,
      # version: "0.1.4",
      version: version(),
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DemoDeploy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:distillery, "~> 1.5"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp version do
    main_version = get_main_version()

    case Mix.env do
      :staging -> main_version <> "+" <> get_build_meta()
      _ -> main_version
    end
  end

  defp get_main_version do
    "VERSION" |> File.read!() |> String.trim()
  end

  defp get_build_meta do
    {cmt, _} = System.cmd("git", ["rev-parse", "HEAD"])
    String.slice(cmt, 0..6)
  end
end
