defmodule Banking.Account.AccountTest do
  use Banking.DataCase

  alias Banking.Account
  alias Banking.User

  @create_attrs %{value: 15.00}
  @invalid_attrs %{value: nil}

  def create_user() do
    User.changeset(%User{}, %{name: "Teste", email: "teste@teste.com", password: "teste"}) |> Repo.insert()
  end

  def fixture() do
    {:ok, user} = create_user()
    {user}
  end

  describe "changeset/2" do
    test "changeset valid data creates a account" do
      {user} = fixture()

      account_with_user = Ecto.build_assoc(user, :account)
      changeset = Account.changeset(account_with_user, @create_attrs)
      assert changeset.valid?
    end

    test "changeset params is required" do
      {user} = fixture()

      account_with_user = Ecto.build_assoc(user, :account)
      changeset = Account.changeset(account_with_user, @invalid_attrs)
      assert changeset.valid? == false
      assert %{
        value: ["can't be blank"]
      } = errors_on(changeset)
    end

  end

end
