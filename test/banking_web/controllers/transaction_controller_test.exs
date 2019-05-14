defmodule BankingWeb.TransactionControllerTest do
  use BankingWeb.ConnCase

  alias Banking.Repo
  alias Banking.User
  alias Banking.Account
  alias Banking.Transaction

  @user_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @account_attrs %{value: 15.00}
  @create_attrs %{type: "DRAW_OUT", value: 10.00}

  def create_user(params) do
    User.changeset(%User{}, params) |> Repo.insert()
  end

  def create_account(user, params) do
    account_with_user = Ecto.build_assoc(user, :account)
    Account.changeset(account_with_user, params) |> Repo.insert()
  end

  def create_transaction(account, params) do
    transaction_with_account = Ecto.build_assoc(account, :transactions)
    Transaction.changeset(transaction_with_account, params) |> Repo.insert()
  end

  def fixture(_) do
    {:ok, user} = create_user(@user_attrs)
    {:ok, account} = create_account(user, @account_attrs)
    {:ok, transaction} = create_transaction(account, @create_attrs)
    {:ok, user: user, account: account, transaction: transaction}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /users/{id}/accounts/{account_id}/transactions - index" do
    setup [:fixture]

    test "renders lists all transactions", %{conn: conn, user: user, account: account, transaction: transaction} do
      conn = get(conn, Routes.transaction_path(conn, :index, user.id, account.id))
      assert json_response(conn, 200) == [
        %{
          "id" => transaction.id,
          "type" => transaction.type,
          "value" => transaction.value,
          "account" => %{"id" => transaction.account_id}
        }
      ]
    end
  end

end
