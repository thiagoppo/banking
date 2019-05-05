defmodule BankingWeb.FallbackControllerTest do
  use BankingWeb.ConnCase

  test "renders error changeset", %{conn: conn} do
    changeset = Banking.User.changeset(%Banking.User{}, %{})
    response = BankingWeb.FallbackController.call(conn, {:error, changeset})
    expected_body = %{errors: %{email: ["can't be blank"], name: ["can't be blank"], password: ["can't be blank"]}} |> Poison.encode!

    assert response.status == 422
    assert response.resp_body == expected_body
  end

  test "renders error not_found", %{conn: conn} do
    response = BankingWeb.FallbackController.call(conn, {:error, :not_found})
    expected_body = %{errors: %{detail: "Not Found"}} |> Poison.encode!

    assert response.status == 404
    assert response.resp_body == expected_body
  end

  test "renders error unauthorized", %{conn: conn} do
    response = BankingWeb.FallbackController.call(conn, {:error, :unauthorized})
    expected_body = %{errors: %{detail: "Unauthorized"}} |> Poison.encode!

    assert response.status == 401
    assert response.resp_body == expected_body
  end

  test "renders error not_allowed", %{conn: conn} do
    response = BankingWeb.FallbackController.call(conn, {:error, :bad_request})
    expected_body = %{errors: %{detail: "Bad Request"}} |> Poison.encode!

    assert response.status == 400
    assert response.resp_body == expected_body
  end

end
