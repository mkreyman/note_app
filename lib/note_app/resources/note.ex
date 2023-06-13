defmodule NoteApp.Note do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  alias NoteApp.Calculations.Markdown

  postgres do
    table "notes"
    repo NoteApp.Repo
  end

  # Defines convenience methods for
  # interacting with the resource programmatically.
  code_interface do
    define_for NoteApp.Notes
    define :create, action: :create
    define :read_all, action: :read
    define :update, action: :update
    define :destroy, action: :destroy
    define :get_by_id, args: [:id], action: :by_id
    define_calculation :html, args: [:content]
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    # Defines custom read action which fetches post by id.
    read :by_id do
      # This action has one argument :id of type :uuid
      argument :id, :uuid, allow_nil?: false
      # Tells us we expect this action to return a single result
      get? true
      # Filters the `:id` given in the argument
      # against the `id` of each element in the resource
      filter expr(id == ^arg(:id))
    end
  end

  calculations do
    calculate :html, :string, {Markdown, field: :content}
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    attribute :content, :string do
      allow_nil? false
    end

    attribute :note_taker_id, Ash.Type.UUID do
      allow_nil? true
    end
  end

  relationships do
    belongs_to :note_taker, NoteApp.NoteTaker do
      attribute_writable? true
    end
  end
end
