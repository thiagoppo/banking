defmodule BankingWeb.TransactionView do
  use BankingWeb, :view
  alias BankingWeb.TransactionView

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      account: %{id: transaction.account_id},
      type: transaction.type,
      value: transaction.value
    }
  end

  def render("index.json", %{transactions: transactions}) do
    render_many(transactions, TransactionView, "transaction.json")
  end

  def render("show.json", %{transaction: transaction}) do
    render_one(transaction, TransactionView, "transaction.json")
  end

end
