defmodule BankingWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :banking, module: Banking.Guardian, error_handler: BankingWeb.AuthController

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
