defmodule Banking.User.UserServiceTest do
  use Banking.DataCase

  alias Banking.User
  alias Banking.UserService
  alias Comeonin.Bcrypt

  @create_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @invalid_attrs %{name: nil, email: nil, password: nil}

  def fixture(_) do
    {:ok, user} = UserService.create(@create_attrs)
    {:ok, user: user}
  end

  describe "all/0" do
    setup [:fixture]

    test "returns all users", %{user: user} do
      assert UserService.all() == [user]
    end
  end

  describe "get!/1" do
    setup [:fixture]

    test "returns the user with given id", %{user: user} do
      assert UserService.get!(user.id) == user
    end
  end

  describe "create/1" do
    test "create user with valid data creates a user" do
      assert {:ok, %User{} = user} = UserService.create(@create_attrs)
      assert user.name == "Teste"
      assert user.email == "teste@teste.com"
      assert Bcrypt.checkpw("teste", user.password) === true
    end

    test "create user and account with value 1000.00" do
      assert {:ok, %User{} = user} = UserService.create(@create_attrs)
      user = Repo.get_by!(User, id: user.id) |> Repo.preload(:account)

      assert user.email == "teste@teste.com"
      assert user.account.value == 1000.00
    end

    test "create user with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserService.create(@invalid_attrs)
    end
  end

  describe "find_and_confirm_password/2" do
    setup [:fixture]

    test "returns the user with given email and password", %{user: user} do
      {:ok, result} = UserService.find_and_confirm_password("teste@teste.com", "teste")
      assert result.id == user.id
    end
  end

end
