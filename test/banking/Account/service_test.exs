defmodule Banking.Account.AccountServiceTest do
  use Banking.DataCase

  alias Banking.Account
  alias Banking.AccountService
  alias Banking.User

  @create_attrs %{value: 15.00}
  @update_attrs %{value: 10.00}
  @invalid_attrs %{value: nil}

  def create_user() do
    User.changeset(%User{}, %{name: "Teste", email: "teste@teste.com", password: "teste"}) |> Repo.insert()
  end

  def create_account(user) do
    account_with_user = Ecto.build_assoc(user, :account)
    Account.changeset(account_with_user, @create_attrs) |> Repo.insert()
  end

  def fixture(_) do
    {:ok, user} = create_user()
    {:ok, account} = create_account(user)
    {:ok, user: user, account: account}
  end

  describe "all/0" do
    setup [:fixture]

    test "returns all accounts", %{account: account} do
      assert AccountService.all() == [account]
    end
  end

  describe "get!/1" do
    setup [:fixture]

    test "returns the account with given id", %{account: account} do
      assert AccountService.get!(account.id) == account
    end
  end

  describe "create/1" do
    test "create account with valid data creates a account" do
      {:ok, user} = create_user()

      assert {:ok, %Account{} = account} = AccountService.create(user, @create_attrs)
      assert account.value == 15.00
      assert account.user_id == user.id
    end

    test "create account with invalid data returns error changeset" do
      {:ok, user} = create_user()

      assert {:error, %Ecto.Changeset{}} = AccountService.create(user, @invalid_attrs)
    end
  end

  describe "update/2" do
    setup [:fixture]

    test "update account with valid data updates the account", %{user: user, account: account} do
      assert {:ok, %Account{} = account} = AccountService.update(account, @update_attrs)
      assert account.user_id == user.id
      assert account.value == 10.00
    end

    test "update account with invalid data returns error changeset", %{account: account} do
      assert {:error, %Ecto.Changeset{}} = AccountService.update(account, @invalid_attrs)
      assert account.value == AccountService.get!(account.id).value
    end
  end

  describe "draw_out/2" do
    setup [:fixture]

    test "successfully withdraw from an account", %{user: user, account: account} do
      assert {:ok, %Account{} = account} = AccountService.draw_out(account.id, 4.00)
      assert account.user_id == user.id
      assert account.value == 11.00
    end

    test "update account with invalid data returns error changeset", %{account: account} do
      assert {:error, %Ecto.Changeset{}} = AccountService.update(account, @invalid_attrs)
      assert account.value == AccountService.get!(account.id).value
    end
  end

end
