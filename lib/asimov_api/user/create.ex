defmodule AsimovApi.User.Create do
  alias AsimovApi.Repo
  alias AsimovApi.Schemas.User

  def call(params) do
    params
    |> User.build()
    |> create_user()
  end

  defp create_user({:ok, struct}) do
    Repo.insert(struct)
  end

  defp create_user({:error, _changeset} = error) do
    error
  end
end
