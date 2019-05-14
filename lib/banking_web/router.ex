defmodule BankingWeb.Router do
  use BankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", BankingWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit, :update, :delete]
    get "/users/:id/accounts/:account_id", AccountController, :show
    post "/users/:id/accounts/:account_id/draw_out", AccountController, :draw_out
    post "/users/:id/accounts/:account_id/transfer", AccountController, :transfer
    get "/users/:id/accounts/:account_id/transactions", TransactionController, :index
  end
end
