defmodule AsimovApi.Repo do
  use Ecto.Repo,
    otp_app: :asimov_api,
    adapter: Ecto.Adapters.Postgres
end
