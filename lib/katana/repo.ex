defmodule Katana.Repo do
  use Ecto.Repo,
    otp_app: :katana,
    adapter: Ecto.Adapters.Postgres
end
