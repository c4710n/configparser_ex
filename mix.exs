defmodule ConfigParser.Mixfile do
  use Mix.Project

  @version "4.0.0"
  @source_url "https://github.com/c4710n/ex_configparser"

  def project do
    [
      app: :configparser,
      version: @version,
      name: "ConfigParser for Elixir",
      source_url: @source_url,
      elixir: ">= 1.7.0",
      package: package(),
      deps: deps(),
      docs: docs(),
      aliases: aliases()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:ordered_map, "~> 0.0.5", only: [:dev, :test, :test_alternative_map]}
    ]
  end

  defp package do
    [
      description: """
      A module that parses INI-like files. Not unlike the Python configparser
      package.
      """,
      maintainers: ["Scott Thompson", "c4710n"],
      files: ["mix.exs", "lib", "LICENSE*", "README*", "CHANGELOG*"],
      licenses: ["BSD-3-Clause"],
      links: %{
        "Changelog" => "https://hexdocs.pm/configparser/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end

  defp docs do
    [
      extras: ["CHANGELOG.md", {:"README.md", [title: "Overview"]}],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end

  defp aliases do
    [
      {:"test.all", [&test/1, &test_alternative_map/1]},
      publish: ["hex.publish", "tag"],
      tag: &tag_release/1
    ]
  end

  defp test(_) do
    Mix.shell().cmd(
      "mix test test/configparser_test.exs",
      env: [{"MIX_ENV", "test"}]
    )
  end

  defp test_alternative_map(_) do
    Mix.shell().cmd(
      "mix test test/configparser_alternative_map_test.exs",
      env: [{"MIX_ENV", "test_alternative_map"}]
    )
  end

  defp tag_release(_) do
    Mix.shell().info("Tagging release as #{@version}")
    System.cmd("git", ["tag", @version])
    System.cmd("git", ["push", "--tags"])
  end
end
