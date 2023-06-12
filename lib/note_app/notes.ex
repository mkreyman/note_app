defmodule NoteApp.Notes do
  use Ash.Api

  resources do
    # This defines the set of resources that can be used with this API
    registry NoteApp.Notes.Registry
  end
end
