defmodule AsimovApiWeb.UsersView do
  use AsimovApiWeb, :view

  alias AsimovApi.Schemas.User

  def render("create.json", %{
        user: %User{id: id, name: name, inserted_at: inserted_at},
        token: token
      }) do
    %{
      message: "User created!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      },
      token: token
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{token: token}
  end

  def render("show.json", %{
        user: %User{id: id, name: name, email: email, inserted_at: inserted_at}
      }) do
    %{
      id: id,
      name: name,
      email: email,
      inserted_at: inserted_at
    }
  end
end
