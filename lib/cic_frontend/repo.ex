defmodule CicFrontend.Repo do
  use Ecto.Repo,
    otp_app: :cic_frontend,
    adapter: Ecto.Adapters.Postgres
end
