defmodule Banking.Transaction.TransactionTest do
  use Banking.DataCase

  alias Banking.User
  alias Banking.Account
  alias Banking.Transaction


  @user_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @account_attrs %{value: 15.00}

  def create_user(params) do
    User.changeset(%User{}, params) |> Repo.insert()
  end

  def create_account(user, params) do
    account_with_user = Ecto.build_assoc(user, :account)
    Account.changeset(account_with_user, params) |> Repo.insert()
  end

  def fixture() do
    {:ok, user} = create_user(@user_attrs)
    {:ok, account} = create_account(user, @account_attrs)
    {:ok, account: account}
  end

  describe "changeset/2" do
    test "changeset valid data creates a transaction" do
      {:ok, account: account} = fixture()

      params = %{type: "DRAW_OUT", value: 10.00}
      transaction_with_account = Ecto.build_assoc(account, :transactions)
      changeset = Transaction.changeset(transaction_with_account, params)
      assert changeset.valid?
    end

    test "changeset type is required" do
      {:ok, account: account} = fixture()

      params = %{}
      transaction_with_account = Ecto.build_assoc(account, :transactions)
      changeset = Transaction.changeset(transaction_with_account, params)
      assert changeset.valid? == false
      assert %{
        type: ["can't be blank"]
      } = errors_on(changeset)
    end

    test "changeset value is required" do
      {:ok, account: account} = fixture()

      params = %{type: "DRAW_OUT"}
      transaction_with_account = Ecto.build_assoc(account, :transactions)
      changeset = Transaction.changeset(transaction_with_account, params)
      assert changeset.valid? == false
      assert %{
        value: ["can't be blank"]
      } = errors_on(changeset)
    end

    test "changeset value is invalid" do
      {:ok, account: account} = fixture()

      params = %{type: "DRAW_OUT", value: "dasdasads"}
      transaction_with_account = Ecto.build_assoc(account, :transactions)
      changeset = Transaction.changeset(transaction_with_account, params)
      assert changeset.valid? == false
      assert %{
        value: ["is invalid"]
      } = errors_on(changeset)
    end

    test "changeset value is not negative" do
      {:ok, account: account} = fixture()

      params = %{type: "DRAW_OUT", value: -1.00}
      transaction_with_account = Ecto.build_assoc(account, :transactions)
      changeset = Transaction.changeset(transaction_with_account, params)
      assert changeset.valid? == false
      assert %{
        value: ["can't be negative"]
      } = errors_on(changeset)
    end

    test "changeset type is invalid" do
      {:ok, account: account} = fixture()

      params = %{type: 1, value: 10.00}
      transaction_with_account = Ecto.build_assoc(account, :transactions)
      changeset = Transaction.changeset(transaction_with_account, params)
      assert changeset.valid? == false
      assert %{
        type: ["is invalid"]
      } = errors_on(changeset)
    end

  end

end
