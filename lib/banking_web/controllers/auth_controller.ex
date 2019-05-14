defmodule BankingWeb.AuthController do
  use BankingWeb, :controller
  import Plug.Conn
  alias Banking.Guardian
  alias Banking.UserService

  action_fallback BankingWeb.FallbackController

  def auth(conn, %{"email" => email, "password" => password}) do
    case UserService.find_and_confirm_password(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        conn
        |> render("auth.json", token: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def auth_error(conn, _, _opts) do
    send_resp(conn, 401, "")
  end

end
