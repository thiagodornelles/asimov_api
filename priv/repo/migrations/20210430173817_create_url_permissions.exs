defmodule AsimovApi.Repo.Migrations.CreateUrlPermissions do
  use Ecto.Migration

  def change do
    create table(:url_permissions) do
      add :url, :string
      add :method, :string
      add :description, :string
      add :user_id, references(:user)
      timestamps()
    end
  end
end
