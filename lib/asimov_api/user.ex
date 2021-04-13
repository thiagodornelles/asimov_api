defmodule ExMon.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id , autogenerate: true}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
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

  def changeset(trainer, params) do
    create_changeset(trainer, params)
  end

  defp create_changeset(module_or_trainer, params) do
    module_or_trainer
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
