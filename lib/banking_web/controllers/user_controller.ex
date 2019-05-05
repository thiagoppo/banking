defmodule BankingWeb.UserController do
  use BankingWeb, :controller

  alias Banking.UserService

  action_fallback BankingWeb.FallbackController


  def index(conn, _params) do
    users = UserService.all()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = UserService.get!(id)
    render(conn, "show.json", user: user)
  end

  def create(conn, params) do
    with {:ok, user} <- UserService.create(params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

end
