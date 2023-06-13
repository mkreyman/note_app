defmodule NoteAppWeb.NoteLive.FormComponent do
  use NoteAppWeb, :live_component

  alias NoteApp.Notes
  alias NoteApp.Note

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage note records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="note-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={AshPhoenix.Form.value(@form, :title)} type="text" label="Title" />
        <.input field={AshPhoenix.Form.value(@form, :content)} type="textarea" label="Content" />
        <.input field={AshPhoenix.Form.value(@form, :note_taker_id)} type="text" label="Note taker" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Note</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{note: note} = assigns, socket) do
    changeset = Notes.change_note(note)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  # def handle_event("validate", %{"note" => note_params}, socket) do
  #   changeset =
  #     socket.assigns.note
  #     |> Notes.change_note(note_params)
  #     |> Map.put(:action, :validate)

  #   {:noreply, assign_form(socket, changeset)}
  # end

  def handle_event("validate", note_params, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, note_params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", note_params, socket) do
    save_note(socket, socket.assigns.action, note_params)
  end

  defp save_note(socket, :edit, note_params) do
    case Notes.update_note(socket.assigns.note, note_params) do
      {:ok, note} ->
        notify_parent({:saved, note})

        {:noreply,
         socket
         |> put_flash(:info, "Note updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_note(socket, :new, note_params) do
    case Notes.create_note(note_params) do
      {:ok, note} ->
        notify_parent({:saved, note})

        {:noreply,
         socket
         |> put_flash(:info, "Note created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, ash_to_form(socket, changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp ash_to_form(socket, %Ash.Changeset{action_type: :update}) do
    socket.assigns.note
    |> AshPhoenix.Form.for_update(:update,
      forms: [
        notes: [
          type: :list,
          resource: Note,
          create_action: :create,
          update_action: :update
        ]
      ]
    )
    |> AshPhoenix.Form.add_form([:notes])
    |> to_form()
  end

  defp ash_to_form(socket, %Ash.Changeset{action_type: :edit}) do
    socket.assigns.note
    |> AshPhoenix.Form.for_update(:update,
      forms: [
        notes: [
          type: :list,
          resource: Note,
          create_action: :create,
          update_action: :update
        ]
      ]
    )
    |> AshPhoenix.Form.add_form([:notes])
    |> to_form()
  end

  defp ash_to_form(_socket, %Ash.Changeset{action_type: action_type} = changeset) when action_type in [:new, :create] do
    changeset
    |> AshPhoenix.Form.for_create(:create,
      forms: [
        notes: [
          type: :list,
          resource: Note,
          create_action: :create,
          update_action: :update
        ]
      ]
    )
    |> AshPhoenix.Form.add_form([:notes])
    |> to_form()
  end
end
