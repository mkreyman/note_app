defmodule NoteApp.Notes.Registry do
  use Ash.Registry,
  extensions: [
    # This extension adds helpful compile time validations
    Ash.Registry.ResourceValidations
  ]

  entries do
    entry NoteApp.Note
    entry NoteApp.NoteTaker
  end
end
