[
  import_deps: [:ecto, :phoenix, :ash, :ash_phoenix, :ash_postgres],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
