defmodule Banking.User.UserServiceTest do
  use Banking.DataCase

  alias Banking.User
  alias Banking.UserService

  @create_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @update_attrs %{name: "Teste2", email: "teste2@teste.com", password: "teste2"}
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
      assert user.password == "teste"
    end

    test "create user with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserService.create(@invalid_attrs)
    end
  end

  describe "update/2" do
    setup [:fixture]

    test "update user with valid data updates the user", %{user: user} do
      assert {:ok, user} = UserService.update(user, @update_attrs)
      assert %User{} = user
      assert user.name == "Teste2"
      assert user.email == "teste2@teste.com"
      assert user.password == "teste2"
    end

    test "update user with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = UserService.update(user, @invalid_attrs)
      assert user.email == UserService.get!(user.id).email
    end
  end

  describe "delete/1" do
    setup [:fixture]

    test "delete user deletes the user", %{user: user} do
      assert {:ok, %User{}} = UserService.delete(user.id)
      assert_raise Ecto.NoResultsError, fn -> UserService.get!(user.id) end
    end
  end

end
