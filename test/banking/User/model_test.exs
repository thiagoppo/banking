defmodule Banking.User.UserTest do
  use Banking.DataCase

  alias Banking.User
  alias Banking.UserService

  @create_attrs %{name: "Teste", email: "teste@teste.com", password: "teste"}
  @invalid_attrs %{name: nil, email: nil, password: nil}

  def fixture(_) do
    {:ok, user} = UserService.create(@create_attrs)
    {:ok, user: user}
  end

  describe "changeset/2" do
    test "changeset valid data creates a user" do
      changeset = User.changeset(%User{}, @create_attrs)
      assert changeset.valid?
    end

    test "changeset params is required" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      assert changeset.valid? == false
      assert %{
        email: ["can't be blank"],
        name: ["can't be blank"],
        password: ["can't be blank"]
      } = errors_on(changeset)
    end

    test "changeset email is unique" do
      fixture(%{})

      {:error, result} = %User{}
        |> User.changeset(@create_attrs)
        |> Repo.insert()

      assert result.valid? == false
      assert result.errors[:email] == {"has already been taken", []}
    end

    test "changeset email is invalid" do
      attrs = %{@create_attrs | email: "teste"}
      changeset = User.changeset(%User{}, attrs)
      assert changeset.valid? == false
      assert %{
        email: ["has invalid format"]
      } = errors_on(changeset)
    end
  end

end
