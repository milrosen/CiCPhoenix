defmodule CicFrontendWeb.DocumentChannel do
  use Phoenix.Channel

  def join("document:" <> _document_id, _params, socket) do
    {:ok, socket}
  end
end
