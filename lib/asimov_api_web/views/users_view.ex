defmodule AsimovApiWeb.UsersView do
  use AsimovApiWeb, :view
  alias AsimovApi.Schemas.User

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
