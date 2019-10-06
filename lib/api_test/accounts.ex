defmodule ApiTest.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ApiTest.Repo

  alias ApiTest.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  alias ApiTest.Accounts.Rules

  @doc """
  Returns the list of rules.

  ## Examples

      iex> list_rules()
      [%Rules{}, ...]

  """
  def list_rules do
    query = from m in Rules,
            join: c in User,
            on: m.user_id == c.id,
            select: %{id: m.id, name: m.name, user_id: m.user_id, user_email: c.email, user_id: c.id }
    Repo.all(query)

  end

  @doc """
  Gets a single rules.

  Raises `Ecto.NoResultsError` if the Rules does not exist.

  ## Examples

      iex> get_rules!(123)
      %Rules{}

      iex> get_rules!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rules!(id), do: Repo.get!(Rules, id)

  @doc """
  Creates a rules.

  ## Examples

      iex> create_rules(%{field: value})
      {:ok, %Rules{}}

      iex> create_rules(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rules(attrs \\ %{}) do
    %Rules{}
    |> Rules.changeset(attrs)
    |> Repo.insert()
  end


  def get_user_rules_in(rules) do
    case Repo.get_by(User, id: rules.user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Updates a rules.

  ## Examples

      iex> update_rules(rules, %{field: new_value})
      {:ok, %Rules{}}

      iex> update_rules(rules, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rules(%Rules{} = rules, attrs) do
    rules
    |> Rules.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Rules.

  ## Examples

      iex> delete_rules(rules)
      {:ok, %Rules{}}

      iex> delete_rules(rules)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rules(%Rules{} = rules) do
    Repo.delete(rules)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rules changes.

  ## Examples

      iex> change_rules(rules)
      %Ecto.Changeset{source: %Rules{}}

  """
  def change_rules(%Rules{} = rules) do
    Rules.changeset(rules, %{})
  end
end
