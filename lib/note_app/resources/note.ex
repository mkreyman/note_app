defmodule NoteApp.Note do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    table "notes"
    repo NoteApp.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :raw_text, :string do
      allow_nil? false
    end

    attribute :html, :string

    attribute :note_taker_id, Ash.Type.UUID do
      allow_nil? false
    end
  end

  relationships do
    belongs_to :note_taker, NoteApp.NoteTaker do
      attribute_writable? true
    end
  end

  def parse_markdown(changeset) do
    raw_text = Ash.Changeset.get_attribute(changeset, :raw_text)
    html = NoteApp.Markdown.parse(raw_text)
    Ash.Changeset.change_attribute(changeset, :html, html)
  end
end
