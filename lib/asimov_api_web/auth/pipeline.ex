defmodule AsimovApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :asimov_api

  plug Guardian.Plug.VerifyHeader, realm: :none
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
