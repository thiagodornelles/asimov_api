defmodule UserController do
  use AsimovApiWeb, :controller

  alias AsimovApi.User
  alias AsimovApi.Guardian

  def create(conn, params) do
    with {:ok, user} <- User.Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
  end

end
