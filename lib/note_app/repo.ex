defmodule NoteApp.Repo do
  use AshPostgres.Repo, otp_app: :note_app

  # Installs Postgres extensions that ash commonly uses
  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
