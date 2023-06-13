defmodule NoteApp.Markdown do
  def parse(raw_text) do
    raw_text
    |> Earmark.as_html!()
    |> parse_checkboxes()
  end

  defp parse_checkboxes(html) do
    String.replace(html, ~r/\[ \]/, "<input type=\"checkbox\">")
    |> String.replace(~r/\[x\]/i, "<input type=\"checkbox\" checked>")
  end
end
