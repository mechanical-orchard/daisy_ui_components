[
  plugins: [Phoenix.LiveView.HTMLFormatter],
  import_deps: [:phoenix],
  subdirectories: ["storybook"],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}"],
  line_length: 120
]
