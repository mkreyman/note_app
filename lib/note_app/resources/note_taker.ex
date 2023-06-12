defmodule NoteApp.NoteTaker do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    table "note_takers"
    repo NoteApp.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string
  end

  relationships do
    # `has_many` means that the destination attribute is not unique, therefore many related records could exist.
    # We assume that the destination attribute is `note_taker_id` based
    # on the module name of this resource and that the source attribute is `id`.
    has_many :notes, NoteApp.Note
  end
end
