defmodule BankingWeb.AuthViewTest do
  use BankingWeb.ConnCase, async: true
  import Phoenix.View

  setup do
    token = "132123addasdas"
    {:ok, token: token}
  end

  test "renders auth.json", %{token: token} do
    assert render(BankingWeb.AuthView, "auth.json", token: token) == %{token: token}
  end

end
