defmodule NoteApp.Note do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    table "notes"
    repo NoteApp.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    create :take do
      accept [:raw_text, :note_taker_id]
    end

    update :assign do
      # No attributes should be accepted
      accept []

      argument :note_taker_id, :uuid do
        allow_nil? false
      end

      # We use a change here to replace the related note_taker
      change manage_relationship(:note_taker_id, :note_taker, type: :append_and_remove)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :raw_text, :string do
      allow_nil? false
    end

    # attribute :html, :string
  end

  relationships do
    belongs_to :note_taker, NoteApp.NoteTaker do
      attribute_writable? true
    end
  end
end
