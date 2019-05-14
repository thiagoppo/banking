defmodule BankingWeb.AccountControllerTest do
  use BankingWeb.ConnCase

  alias Banking.Guardian
  alias Banking.Repo
  alias Banking.User
  alias Banking.Account
  alias Banking.AccountService

  @user_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @create_attrs %{value: 15.00}

  def create_user(params) do
    User.changeset(%User{}, params) |> Repo.insert()
  end

  def create_account(user, params) do
    account_with_user = Ecto.build_assoc(user, :account)
    Account.changeset(account_with_user, params) |> Repo.insert()
  end

  def setToken(conn, user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user)
    conn = put_req_header(conn, "authorization", "Bearer #{token}")
    {:ok, conn: conn}
  end

  def fixture(_) do
    {:ok, user} = create_user(@user_attrs)
    {:ok, account} = create_account(user, @create_attrs)
    {:ok, user: user, account: account}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /users/{id}/accounts/{account_id} - show" do
    setup [:fixture]

    test "renders account detail", %{conn: conn, user: user, account: account} do
      {:ok, conn: conn} = setToken(conn, user)
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

      {:ok, conn: conn} = setToken(conn, user)
      conn = post(conn, Routes.account_path(conn, :draw_out, user.id, account.id), payload)
      assert json_response(conn, 200) == %{
        "id" => account.id,
        "value" => 10.00
      }
    end
  end

  describe "POST /users/{id}/accounts/{account_id}/transfer - transfer" do
    setup [:fixture]

    test "should transfer value successfully", %{conn: conn, user: user, account: account} do
      {:ok, destiny_user} = create_user(%{@user_attrs | email: "teste2@teste.com"})
      {:ok, destiny_account} = create_account(destiny_user, @create_attrs)

      payload = %{destiny_account_id: destiny_account.id, value: 5.00}

      {:ok, conn: conn} = setToken(conn, user)
      conn = post(conn, Routes.account_path(conn, :transfer, user.id, account.id), payload)
      assert json_response(conn, 200) == %{
        "id" => account.id,
        "value" => 10.00
      }
    end

    test "not transfer when the param account is negative", %{conn: conn, user: user, account: account} do
      {:ok, destiny_user} = create_user(%{@user_attrs | email: "teste2@teste.com"})
      {:ok, destiny_account} = create_account(destiny_user, @create_attrs)

      payload = %{destiny_account_id: destiny_account.id, value: -5.00}

      {:ok, conn: conn} = setToken(conn, user)
      conn = post(conn, Routes.account_path(conn, :transfer, user.id, account.id), payload)
      assert json_response(conn, 400) != %{}
      assert AccountService.get!(account.id).value == 15.00
      assert AccountService.get!(destiny_account.id).value == 15.00
    end
  end

end
