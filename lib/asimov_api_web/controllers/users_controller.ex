defmodule AsimovApiWeb.UsersController do
  use AsimovApiWeb, :controller
  use PhoenixSwagger

  alias AsimovApi.User
  alias AsimovApiWeb.Auth.Guardian

  action_fallback AsimovApiWeb.FallbackController

  swagger_path :create do
    post "/api/users"
    description "Create an user"
    parameters do
      name :query, :string, "User name", required: true, example: 42
      email :query, :string, "User email", required: true
      password :query, :string, "User password", required: true
    end
    security [%{Bearer: []}]
    response 200, "Returns data from the created user"
  end

  def create(conn, params) do
    with {:ok, user} <- User.Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
  end

  swagger_path :sign_in do
    post "/api/users/signin"
    description "Sign in to the API"
    parameters do
      id :query, :integer, "User ID", required: true, example: 42
      password :query, :string, "User password", required: true
    end
    response 200, "Returns the JWT token"
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  swagger_path :show do
    get "/api/users/{id}"
    description "Get an user by ID"
    parameter :id, :path, :integer, "User ID", required: true, example: 42
    security [%{Bearer: []}]
    response 200, "Returns users data"
  end

  def show(conn, %{"id" => id}) do
    id
    |> User.Get.call()
    |> handle_response(conn, "show.json", :ok)
  end

  defp handle_response({:ok, user}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, user: user)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status) do
    error
  end
end
