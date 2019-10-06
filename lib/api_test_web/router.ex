defmodule ApiTestWeb.Router do
  use ApiTestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ApiTest.Auth.Pipeline
  end

  scope "/api", ApiTestWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  scope "/api", ApiTestWeb do
    pipe_through [:api, :auth]
    resources "/rules", RulesController, except: [:new ]
    resources "/businesses", BusinessController, except: [:new]
  end
end
