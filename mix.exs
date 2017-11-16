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
    app_version = System.get_env("APP_VERSION")
    if app_version && app_version != "" do
      IO.puts ">>> use app_version #{app_version}"
      app_version
    else
      IO.puts ">>> calc version"
      {cmt, _} = System.cmd("git", ["rev-parse", "HEAD"])
      hash = String.slice(cmt, 0..6)
      IO.puts ">>> cmt: #{cmt}"

      vsn = "0.1.0"
      "#{vsn}+#{hash}"
    end
  end
end
