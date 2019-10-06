defmodule ApiTestWeb.UserView do
  use ApiTestWeb, :view
  alias ApiTestWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }

    # %{
    #   id: user.id,
    #   email: user.email,
    #   encrypted_password: user.encrypted_password
    # }
  end
end
