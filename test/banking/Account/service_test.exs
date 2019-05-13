defmodule Banking.Account.AccountServiceTest do
  use Banking.DataCase

  alias Banking.Account
  alias Banking.AccountService
  alias Banking.User

  @user_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @create_attrs %{value: 15.00}
  @update_attrs %{value: 10.00}
  @invalid_attrs %{value: nil}

  def create_user(params) do
    User.changeset(%User{}, params) |> Repo.insert()
  end

  def create_account(user, params) do
    account_with_user = Ecto.build_assoc(user, :account)
    Account.changeset(account_with_user, params) |> Repo.insert()
  end

  def fixture(_) do
    {:ok, user} = create_user(@user_attrs)
    {:ok, account} = create_account(user, @create_attrs)
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
      {:ok, user} = create_user(@user_attrs)

      assert {:ok, %Account{} = account} = AccountService.create(user, @create_attrs)
      assert account.value == 15.00
      assert account.user_id == user.id
    end

    test "create account with invalid data returns error changeset" do
      {:ok, user} = create_user(@user_attrs)

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

    test "should not draw if the final result", %{account: account} do
      assert {:error, %Ecto.Changeset{}} = AccountService.draw_out(account.id, 16.00)
      assert AccountService.get!(account.id) == account
    end

    test "update account with invalid data returns error changeset", %{account: account} do
      assert {:error, %Ecto.Changeset{}} = AccountService.update(account, @invalid_attrs)
      assert account.value == AccountService.get!(account.id).value
    end
  end

  describe "transfer/3" do
    setup [:fixture]

    test "should transfer value successfully", %{account: account} do
      {:ok, destiny_user} = create_user(%{@user_attrs | email: "teste2@teste.com"})
      {:ok, destiny_account} = create_account(destiny_user, @create_attrs)

      assert {:ok, %Account{} = account} = AccountService.transfer(account.id, destiny_account.id, 4.00)
      assert account.value == 11.00
      assert AccountService.get!(destiny_account.id).value == 19.00
    end

    test "not transfer when the account balance is negative", %{account: account} do
      {:ok, destiny_user} = create_user(%{@user_attrs | email: "teste2@teste.com"})
      {:ok, destiny_account} = create_account(destiny_user, @create_attrs)

      assert {:error, %Ecto.Changeset{}} = AccountService.transfer(account.id, destiny_account.id, 16.00)
      assert AccountService.get!(account.id).value == 15.00
      assert AccountService.get!(destiny_account.id).value == 15.00
    end
  end

end
