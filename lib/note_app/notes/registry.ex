defmodule NoteApp.Notes.Registry do
  use Ash.Registry

  entries do
    entry NoteApp.Note
    entry NoteApp.NoteTaker
  end
end
