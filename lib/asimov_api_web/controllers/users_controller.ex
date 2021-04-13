defmodule AsimovApiWeb.UsersController do
  use AsimovApiWeb, :controller
  use PhoenixSwagger

  alias AsimovApi.User
  alias AsimovApi.Guardian

  action_fallback AsimovApiWeb.FallbackController

  swagger_path :create do
    post "/api/create"
    summary "Create an user"
    description "Create an user"
    # parameter :ery, :id, :integer, "account id", required: true
    response 200, "Description", :Users
    tag "users"
  end

  def create(conn, params) do
    with {:ok, user} <- User.Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
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
    summary "Get users"
    description "Get an user by ID"
    parameter :id, :path, :integer, "User ID", required: true, example: 3
    response 200, "Description", :Users
    tag "users"
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
