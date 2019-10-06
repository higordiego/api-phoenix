defmodule ApiTestWeb.RulesView do
  use ApiTestWeb, :view
  alias ApiTestWeb.RulesView

  def render("index.json", %{rules: rules}) do
    %{data: render_many(rules, RulesView, "rules.json")}
  end

  def render("show.json", %{rules: rules}) do
    %{data: render_one(rules, RulesView, "rules.json")}
  end

  def render("rules.json", %{rules: rules})do
    %{
      id: rules.id,
      name: rules.name,
      user_id: rules.user_id,
      user: rules_user(rules)
    }
  end


  defp rules_user(rules) do
    case Map.fetch(rules, :user_email) do
      :error -> nil
      { :ok, result } -> %{"email" => result, "id" => rules.user_id }
    end
  end

end
