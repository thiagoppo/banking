defmodule BankingWeb.AccountControllerTest do
  use BankingWeb.ConnCase

  alias Banking.Repo
  alias Banking.User
  alias Banking.Account

  def create_user() do
    User.changeset(%User{}, %{name: "Teste", email: "teste@teste.com", password: "teste"}) |> Repo.insert()
  end

  def create_account(user) do
    account_with_user = Ecto.build_assoc(user, :account)
    Account.changeset(account_with_user, %{value: 15.00}) |> Repo.insert()
  end

  def fixture(_) do
    {:ok, user} = create_user()
    {:ok, account} = create_account(user)
    {:ok, user: user, account: account}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /users/{id}/accounts/{account_id} - show" do
    setup [:fixture]

    test "renders account detail", %{conn: conn, user: user, account: account} do
      conn = get(conn, Routes.account_path(conn, :show, user.id, account.id))
      assert json_response(conn, 200) == %{
        "id" => account.id,
        "value" => 15.00
      }
    end
  end

  describe "POST /users/{id}/accounts/{account_id}/draw_out - draw_out" do
    setup [:fixture]

    test "must successfully withdraw account value", %{conn: conn, user: user, account: account} do
      payload = %{value: 5.00}

      conn = post(conn, Routes.account_path(conn, :draw_out, user.id, account.id), payload)
      assert json_response(conn, 200) == %{
        "id" => account.id,
        "value" => 10.00
      }
    end
  end

end
