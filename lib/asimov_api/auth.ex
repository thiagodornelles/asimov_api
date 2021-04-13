defmodule AsimovApi.Auth.Guardian do
  use Guardian, otp_app: :ex_mon

  alias AsimovApi.Repo
  alias AsimovApi.User

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> AsimovApi.User.Get.call()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    case Repo.get(User, user_id) do
      nil -> {:error, "User not found"}
      user -> validate_password(User, password)
    end
  end

  def validate_password(%User{password_hash: hash} = User, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(User)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(User) do
    {:ok, token, _claims} = encode_and_sign(User)
    {:ok, token}
  end
end
