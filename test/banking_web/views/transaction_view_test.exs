defmodule BankingWeb.TransactionViewTest do
  use BankingWeb.ConnCase, async: true
  import Phoenix.View

  setup do
    transaction = %{id: 1, type: "DRAW_OUT", value: 10.00, account_id: 1}
    {:ok, transaction: transaction}
  end

  test "renders transaction.json", %{transaction: transaction} do
    assert render(BankingWeb.TransactionView, "transaction.json", transaction: transaction) == %{
      id: 1, type: "DRAW_OUT", value: 10.00, account: %{id: 1}}
  end

  test "renders index.json", %{transaction: transaction} do
    transactions = [transaction]
    assert render(BankingWeb.TransactionView, "index.json", transactions: transactions) == [
      %{id: 1, type: "DRAW_OUT", value: 10.00, account: %{id: 1}}
    ]
  end

  test "renders show.json", %{transaction: transaction} do
    assert render(BankingWeb.TransactionView, "show.json", transaction: transaction) == %{
      id: 1, type: "DRAW_OUT", value: 10.00, account: %{id: 1}}
  end

end
