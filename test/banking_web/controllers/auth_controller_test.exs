defmodule BankingWeb.AuthControllerTest do
  use BankingWeb.ConnCase

  alias Banking.UserService

  @create_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}

  def fixture(_) do
    {:ok, user} = UserService.create(@create_attrs)
    {:ok, user: user}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "POST /auth - authenticate" do
    setup [:fixture]

    test "should authenticate successfully", %{conn: conn} do
      payload = %{email: "teste@teste.com", password: "teste"}

      conn = post(conn, Routes.auth_path(conn, :auth), payload)
      assert %{"token" => token} = json_response(conn, 200)
    end

    test "Should not authenticate when error occurs", %{conn: conn} do
      payload = %{email: "teste@teste.com", password: "123"}

      conn = post(conn, Routes.auth_path(conn, :auth), payload)
      assert json_response(conn, 401) != %{}
    end
  end

end
