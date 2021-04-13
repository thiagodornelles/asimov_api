defmodule AsimovApi.User.Get do
  alias AsimovApi.Repo
  alias AsimovApi.Schemas.User

  def call(id) do
    IO.inspect(id)
    case Integer.parse(id, 10) do
      :error -> {:error, "Invalid ID format!"}
      {id, _} -> get_user(id)
    end
  end

  defp get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
