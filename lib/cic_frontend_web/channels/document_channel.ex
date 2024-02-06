defmodule CicFrontendWeb.DocumentChannel do
  use Phoenix.Channel

  def join("document:" <> _document_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("code_update", %{"body" => [_, new]}, socket) do
    body =
      case CalculusOfInductiveTypes.typeProof(new) do
        {:ok, types} -> %{:ok => types}
        {:typeError, errorMsg} -> %{:typeError => errorMsg}
      end

    broadcast!(socket, "type_check", %{body: body})
    {:noreply, socket}
  end
end
