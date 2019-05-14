defmodule BankingWeb.TransactionController do
  use BankingWeb, :controller

  alias Banking.TransactionService

  action_fallback BankingWeb.FallbackController

  def index(conn, %{"account_id" => account_id}) do
    transactions = TransactionService.filter_by_account_id(account_id)
    render(conn, "index.json", transactions: transactions)
  end

end
