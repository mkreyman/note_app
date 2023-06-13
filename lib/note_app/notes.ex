defmodule NoteApp.Notes do
  use Ash.Api

  alias NoteApp.Note

  resources do
    # This defines the set of resources that can be used with this API
    registry NoteApp.Notes.Registry
  end

  def list_notes!() do
    Note.read_all!
      |> Enum.map(fn note ->
        %Note{id: note.id, title: note.title, content: Note.html!(note.content) |> Phoenix.HTML.raw}
      end)
  end

  def get_note!(id) do
    Note.get_by_id!(id)
  end

  def delete_note!(note) do
    Note.get_by_id!(note.id) |> Note.destroy!()
  end

  def change_note(note) do
    note.id
    |> NoteApp.Note.get_by_id!()
    |> Ash.Changeset.for_update(:update)
  end
end
