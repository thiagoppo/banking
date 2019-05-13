defmodule BankingWeb.AccountController do
  use BankingWeb, :controller

  alias Banking.AccountService
  alias BankingWeb.Support.Validation

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

  def transfer(conn, params) do
    try do
      params_validations = %{destiny_account_id: [:required], value: [:required, :is_not_negative]}
      Validation.validate(params_validations, params)
      with {:ok, account } <- AccountService.transfer(params["account_id"], params["destiny_account_id"], params["value"]) do
        render(conn, "show.json", account: account)
      end
    rescue
      e in RuntimeError -> {:error, %{detail: e.message}}
    end
  end

end
