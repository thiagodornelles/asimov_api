defmodule AsimovApiWeb.FallbackController do
  use AsimovApiWeb, :controller

  def call(conn, {:error, %{message: _message, status: status = result}}) do
    conn
    |> put_status(status)
    |> put_view(AsimovApiWeb.ErrorView)
    |> render("400.json", result: result)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(AsimovApiWeb.ErrorView)
    |> render("401.json", message: "User unauthorized")
  end

  def call(conn, {:error, result}) do
    # IO.puts("Default fallback")
    conn
    |> put_status(:bad_request)
    |> put_view(AsimovApiWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
