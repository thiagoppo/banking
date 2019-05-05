defmodule BankingWeb.FallbackController do
  use BankingWeb, :controller

  alias BankingWeb.ChangesetView
  alias BankingWeb.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ErrorView, "404.json", %{})
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(ErrorView, "401.json", %{})
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(:bad_request)
    |> render(ErrorView, "400.json", %{})
  end
end
