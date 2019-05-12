defmodule BankingWeb.AccountController do
  use BankingWeb, :controller

  alias Banking.AccountService

  action_fallback BankingWeb.FallbackController

  def show(conn, %{"account_id" => account_id}) do
    account = AccountService.get!(account_id)
    render(conn, "show.json", account: account)
  end

  def draw_out(conn, params) do
    with {:ok, account } <- AccountService.draw_out(params["account_id"], params["value"]) do
      render(conn, "show.json", account: account)
    end
  end

end
