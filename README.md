# Banking

## Technologies
  - Elixir
  - Phoenix
  - Ecto
  - Guardian
  - Bcrypt
  - JWT
  - Postgres
  - Docker

## To start your Project:
  - Start container docker `docker-compose up -d`
  - http://localhost:4000
  - Run tests `docker exec -it banking_app bash mix test`

## Documentation API:
  * You can take this token and add it to Authorization: Bearer #{token} header
  - POST /api/v1/auth -> Authenticate user (email, password)
    - `curl --request POST \
    --url http://localhost:4000/api/v1/auth \
    --header 'content-type: application/json' \
    --data '{
    "email": "teste@teste.com",
    "password": "123456"}'`
  - POST /api/v1/users -> Create user and account (name, email, password)
    - `curl --request POST \
        --url http://localhost:4000/api/v1/users \
        --header 'content-type: application/json' \
        --data '{
        "email": "teste@teste.com",
        "name": "teste",
        "password": "123456"
      }'`
  - GET /api/v1/users/:id -> View user details
    - `curl --request GET \
      --url http://localhost:4000/api/v1/users/1 \
      --header 'authorization: Bearer {token}' \
      --data '{
      "email": "teste@teste.com",
      "password": "123456"
    }'`
  - GET /api/v1/users/:id/accounts/:account_id -> View account details
    - `curl --request GET \
      --url http://localhost:4000/api/v1/users/1/accounts/1 \
      --header 'authorization: Bearer {token}'`
  - POST /api/v1/users/:id/accounts/:account_id/draw_out -> Cash out of account (value)
    - `curl --request POST \
      --url http://localhost:4000/api/v1/users/1/accounts/1/draw_out \
      --header 'authorization: Bearer {token}' \
      --header 'content-type: application/json' \
      --data '{
      "value": 10.00
    }'`
  - POST /api/v1/users/:id/accounts/:account_id/transfer -> Transfers money to another account (destiny_account_id, value)
    - `curl --request POST \
      --url http://localhost:4000/api/v1/users/1/accounts/1/transfer \
      --header 'authorization: Bearer {token}' \
      --header 'content-type: application/json' \
      --data '{
      "destiny_account_id": 1,
      "value": 10.00
    }'`
  - GET /api/v1/users/:id/accounts/:account_id/transactions -> View account transactions
    - `curl --request GET \
      --url http://localhost:4000/api/v1/users/1/accounts/1/transactions \
      --header 'authorization: Bearer {token}'`