defmodule BankingWeb.AuthView do
  use BankingWeb, :view

  def render("auth.json", %{token: token}) do
    %{
      token: token
    }
  end
end
