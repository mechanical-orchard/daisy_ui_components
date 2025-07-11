defmodule DaisyUIComponentsSite.MixProject do
  use Mix.Project

  def project do
    [
      app: :daisy_ui_components_site,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      listeners: [Phoenix.CodeReloader]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DaisyUIComponentsSite.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.8.0-rc.3", override: true},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.1.0-rc.2", override: true},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.3", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons", tag: "v2.1.1", sparse: "optimized", app: false, compile: false, depth: 1},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.3"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.2"},
      {:bandit, "~> 1.2"},
      # When actively modifying phoenix_storybook code use this:
      # {:phoenix_storybook, path: "../../phoenix_storybook"},
      # The MO fork of phoenix_storybook contains the theme selector for DaisyUI
      # (i.e., it sets <html data-theme="light" /> or <html data-theme="dark" />
      {:phoenix_storybook, github: "mechanical-orchard/phoenix_storybook"},
      {:daisy_ui_components, path: "../"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": [
        "tailwind.install --if-missing",
        "esbuild.install --if-missing"
      ],
      "assets.build": [
        "tailwind daisy_ui_components_site",
        "tailwind storybook",
        "esbuild daisy_ui_components_site",
        "esbuild storybook",
        "dev.storybook"
      ],
      "assets.deploy": [
        "tailwind daisy_ui_components_site --minify",
        "esbuild daisy_ui_components_site --minify",
        "tailwind storybook --minify",
        "esbuild storybook --minify",
        "phx.digest"
      ]
    ]
  end
end
