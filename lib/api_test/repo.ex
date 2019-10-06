defmodule ApiTest.Repo do
  use Ecto.Repo,
    otp_app: :api_test,
    adapter: Ecto.Adapters.MyXQL
end
