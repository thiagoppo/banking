defmodule BankingWeb.UserViewTest do
  use BankingWeb.ConnCase, async: true
  import Phoenix.View

  setup do
    user = %{id: 1, name: "teste", email: "teste@teste.com"}
    {:ok, user: user}
  end

  test "renders user.json", %{user: user} do
    assert render(BankingWeb.UserView, "user.json", user: user) == user
  end

  test "renders index.json", %{user: user} do
    users = [user]
    assert render(BankingWeb.UserView, "index.json", users: users) == users
  end

  test "renders show.json", %{user: user} do
    assert render(BankingWeb.UserView, "show.json", user: user) == user
  end

end
