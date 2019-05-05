defmodule BankingWeb.Router do
  use BankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", BankingWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
  end
end
