# NoteApp

To start your NoteApp server:

- Run `docker-compose up -d` to start a Docker container with Postgres. It will run on port 5433 to avoid possible conflict with your local db installation.
- Run `mix setup` to install and setup dependencies.
- Run `mix db.setup` to create NoteApp's db and run migrations.
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Navigate to [`localhost:4000`](http://localhost:4000/notes) from your browser.

Visit this [blog post](https://github.blog/2014-04-28-task-lists-in-all-markdown-documents/) to get an idea of what this test app is trying to do.

_\*Built with [Ash Framework](https://ash-hq.org/)_.
