defmodule BankingWeb.ErrorViewTest do
  use BankingWeb.ConnCase, async: true
  import Phoenix.View

  test "renders 500.json" do
    assert render(BankingWeb.ErrorView, "500.json", []) ==
           %{errors: %{detail: "Internal Server Error"}}
  end

  test "renders 404.json" do
    assert render(BankingWeb.ErrorView, "404.json", []) ==
           %{errors: %{detail: "Not Found"}}
  end

  test "renders 401.json" do
    assert render(BankingWeb.ErrorView, "401.json", []) ==
           %{errors: %{detail: "Unauthorized"}}
  end

  test "renders 400.json" do
    assert render(BankingWeb.ErrorView, "400.json", []) ==
           %{errors: %{detail: "Bad Request"}}
  end

end
