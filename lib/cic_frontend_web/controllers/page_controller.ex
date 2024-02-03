defmodule CicFrontendWeb.PageController do
  use CicFrontendWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/proof")
  end
end
