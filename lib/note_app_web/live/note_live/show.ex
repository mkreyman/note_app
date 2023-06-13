defmodule NoteAppWeb.NoteLive.Show do
  use NoteAppWeb, :live_view

  alias NoteApp.Notes
  alias NoteApp.Note

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    note = Notes.get_note!(id)
    content = note.content |> Note.html!() |> raw()

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:note, %{note | content: content})}
  end

  defp page_title(:show), do: "Show Note"
  defp page_title(:edit), do: "Edit Note"
end
