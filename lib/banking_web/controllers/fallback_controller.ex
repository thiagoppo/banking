defmodule BankingWeb.FallbackController do
  use BankingWeb, :controller

  alias BankingWeb.ChangesetView
  alias BankingWeb.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", %{})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", %{})
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render("401.json", %{})
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", %{})
  end
end
