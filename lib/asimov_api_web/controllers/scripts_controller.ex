defmodule AsimovApiWeb.ScriptsController do
  use AsimovApiWeb, :controller
  use PhoenixSwagger

  action_fallback AsimovApiWeb.FallbackController

  swagger_path :create do
    post("/api/scripts")
    description("Create a new script")

    parameters do
      name(:query, :string, "User name", required: true, example: 42)
      email(:query, :string, "User email", required: true)
      password(:query, :string, "User password", required: true)
    end

    security([%{Bearer: []}])
    response(200, "Returns data from the created user")
  end

  def create(conn, params) do
    conn
    |> put_status(:created)
    |> render("create.json", params)
  end
end
