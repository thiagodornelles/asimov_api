defmodule AsimovApiWeb.UsersController do
  use AsimovApiWeb, :controller

  alias AsimovApi.User
  alias AsimovApi.Guardian

  action_fallback AsimovApiWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- User.Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
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

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error

end
