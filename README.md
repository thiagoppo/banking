# Banking

- Elixir
- Phoenix
- Ecto
- Postgres
- Docker

To start your Project:

  * Start container docker `docker-compose up -d`
  * http://localhost:4000
  * Run tests `docker exec -it banking_app bash mix test`

Documentation:
- POST /api/v1/auth -> Authenticate user (email, password)
- POST /api/v1/users -> Create user and account (name, email, password)
- GET /api/v1/users/:id/accounts/:id -> View account details
- POST /api/v1/users/:id/accounts/:id/draw_out -> Cash out of account (value)
- POST /api/v1/users/:id/accounts/:id/transfer -> Transfers money to another account (account_id, value)
- GET /api/v1/users/:id/accounts/:id/transactions -> View account transactions
