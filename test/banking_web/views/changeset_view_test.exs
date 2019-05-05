defmodule BankingWeb.ChangesetViewTest do
  use BankingWeb.ConnCase, async: true
  import Phoenix.View

  test "renders changeset error" do
    changeset = Banking.User.changeset(%Banking.User{}, %{})
    result = render(BankingWeb.ChangesetView, "error.json", changeset: changeset)
    expected = %{errors: %{email: ["can't be blank"], name: ["can't be blank"], password: ["can't be blank"]}}

    assert result == expected
  end

end
