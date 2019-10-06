defmodule ApiTest.Auth.Pipeline do
  use Guardian.Plug.Pipeline,

    otp_app: :api_test,
    module: ApiTest.Auth.Guardian,
    error_handler: ApiTest.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
