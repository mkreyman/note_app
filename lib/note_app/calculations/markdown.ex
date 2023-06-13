defmodule NoteApp.Calculations.Markdown do
  use Ash.Calculation

  def calculate(records, opts, _) do
    {:ok,
     Enum.map(records, fn record ->
       record
       |> Map.get(opts[:field])
       |> case do
         nil ->
           nil

         value ->
           parse(value)
       end
     end)}
  end

  def select(_, opts, _) do
    [opts[:field]]
  end

  def load(_, opts, _) do
    [opts[:field]]
  end

  defp parse(content) do
    content
    |> Earmark.as_html!()
    |> parse_checkboxes()
  end

  defp parse_checkboxes(html) do
    String.replace(html, ~r/\[ \]/, "<input type=\"checkbox\">")
    |> String.replace(~r/\[x\]/i, "<input type=\"checkbox\" checked>")
  end
end
