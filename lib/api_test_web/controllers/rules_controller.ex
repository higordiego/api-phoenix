defmodule ApiTestWeb.RulesController do
  use ApiTestWeb, :controller

  alias ApiTest.Accounts
  alias ApiTest.Accounts.User
  alias ApiTest.Accounts.Rules

  action_fallback ApiTestWeb.FallbackController

  def index(conn, _params) do
    rules = Accounts.list_rules()
    render(conn, "index.json", rules: rules)
  end


  defp user_rules_email(rules, user), do: Map.new([rules, user])


  def create(conn, %{"rules" => rules_params}) do
    with {:ok, %Rules{} = rules}  <- Accounts.create_rules(rules_params) do
        conn
        |> put_status(:created)
        |> render("rules.json", %{rules: rules})
    end
  end

  def show(conn, %{"id" => id}) do
    rules = Accounts.get_rules!(id)
    render(conn, "show.json", %{rules: rules})
  end

  def update(conn, %{"id" => id, "rules" => rules_params}) do
    rules = Accounts.get_rules!(id)

    with {:ok, %Rules{} = rules} <- Accounts.update_rules(rules, rules_params) do
      render(conn, "show.json", rules: rules)
    end
  end

  def delete(conn, %{"id" => id}) do
    rules = Accounts.get_rules!(id)

    with {:ok, %Rules{}} <- Accounts.delete_rules(rules) do
      send_resp(conn, :no_content, "")
    end
  end
end
