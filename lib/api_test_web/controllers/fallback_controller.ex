defmodule ApiTestWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ApiTestWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ApiTestWeb.ChangesetView, "error.json", changeset: changeset)

    # |> put_view(ApiTestWeb.ChangesetView)
    # |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(ApiTestWeb.ErrorView, :"401")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ApiTestWeb.ErrorView, :"404")

    # |> put_view(ApiTestWeb.ErrorView)
    # |> render(:"404")
  end
end
