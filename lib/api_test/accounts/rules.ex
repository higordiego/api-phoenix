defmodule ApiTest.Accounts.Rules do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rules" do
    field :name, :string
    field :user_id, :id
    field :user, :map, virtual: true

    timestamps()
  end

  @doc false
  def changeset(rules, attrs) do
    rules
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
