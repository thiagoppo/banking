defmodule Banking.Account.TransactionServiceTest do
  use Banking.DataCase

  alias Banking.User
  alias Banking.Account
  alias Banking.Transaction
  alias Banking.TransactionService

  @user_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @account_attrs %{value: 15.00}
  @create_attrs %{type: "DRAW_OUT", value: 10.00}
  @invalid_attrs %{type: nil, value: nil}

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

  describe "all/0" do
    setup [:fixture]

    test "returns all accounts", %{transaction: transaction} do
      assert TransactionService.all() == [transaction]
    end
  end

  describe "filter_by_account_id/0" do
    setup [:fixture]

    test "returns all transactions by account_id", %{transaction: transaction} do
      assert TransactionService.filter_by_account_id(transaction.account_id) == [transaction]
    end
  end

  describe "create/1" do
    test "create transaction with valid data creates a transaction" do
      {:ok, user} = create_user(@user_attrs)
      {:ok, account} = create_account(user, @account_attrs)

      assert {:ok, %Transaction{} = transaction} = TransactionService.create(account, @create_attrs)
      assert transaction.type == "DRAW_OUT"
      assert transaction.value == 10.00
      assert transaction.account_id == account.id
    end

    test "create account with invalid data returns error changeset" do
      {:ok, user} = create_user(@user_attrs)
      {:ok, account} = create_account(user, @account_attrs)

      assert {:error, %Ecto.Changeset{}} = TransactionService.create(account, @invalid_attrs)
    end
  end

end
