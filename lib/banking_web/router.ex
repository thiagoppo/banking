defmodule BankingWeb.Router do
  use BankingWeb, :router
  alias BankingWeb.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", BankingWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/auth", AuthController, :auth

    pipe_through :authenticated

    get "/users", UserController, :index
    get "/users/:id", UserController, :show

    get "/users/:id/accounts/:account_id", AccountController, :show
    post "/users/:id/accounts/:account_id/draw_out", AccountController, :draw_out
    post "/users/:id/accounts/:account_id/transfer", AccountController, :transfer
    get "/users/:id/accounts/:account_id/transactions", TransactionController, :index
  end
end
