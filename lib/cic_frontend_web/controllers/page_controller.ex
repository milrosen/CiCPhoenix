defmodule CicFrontendWeb.PageController do
  use CicFrontendWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/proof?id=2128f977-a7e2-4b49-8ab0-955d1a219b79")
  end
end
