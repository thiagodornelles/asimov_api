defmodule AsimovApi.Schemas.URLPermission do
  use Ecto.Schema
  import Ecto.Changeset

  alias AsimovApiWeb.Schemas.User

  @primary_key {:id, :id, autogenerate: true}

  schema "url_permissions" do
    field :url, :string
    field :method, :string

    belongs_to :user, User
    timestamps()
  end

  @required_params [:name, :email, :password]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    create_changeset(%__MODULE__{}, params)
  end

  def changeset(user, params) do
    create_changeset(user, params)
  end

  defp create_changeset(module_or_user, params) do
    module_or_user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset) do
    changeset
  end
end
