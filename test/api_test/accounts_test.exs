defmodule ApiTest.AccountsTest do
  use ApiTest.DataCase

  alias ApiTest.Accounts

  describe "users" do
    alias ApiTest.Accounts.User

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password"}
    @update_attrs %{
      email: "some updated email",
      encrypted_password: "some updated encrypted_password"
    }
    @invalid_attrs %{email: nil, encrypted_password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.encrypted_password == "some encrypted_password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.encrypted_password == "some updated encrypted_password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "rules" do
    alias ApiTest.Accounts.Rules

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def rules_fixture(attrs \\ %{}) do
      {:ok, rules} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_rules()

      rules
    end

    test "list_rules/0 returns all rules" do
      rules = rules_fixture()
      assert Accounts.list_rules() == [rules]
    end

    test "get_rules!/1 returns the rules with given id" do
      rules = rules_fixture()
      assert Accounts.get_rules!(rules.id) == rules
    end

    test "create_rules/1 with valid data creates a rules" do
      assert {:ok, %Rules{} = rules} = Accounts.create_rules(@valid_attrs)
      assert rules.name == "some name"
    end

    test "create_rules/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_rules(@invalid_attrs)
    end

    test "update_rules/2 with valid data updates the rules" do
      rules = rules_fixture()
      assert {:ok, %Rules{} = rules} = Accounts.update_rules(rules, @update_attrs)
      assert rules.name == "some updated name"
    end

    test "update_rules/2 with invalid data returns error changeset" do
      rules = rules_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_rules(rules, @invalid_attrs)
      assert rules == Accounts.get_rules!(rules.id)
    end

    test "delete_rules/1 deletes the rules" do
      rules = rules_fixture()
      assert {:ok, %Rules{}} = Accounts.delete_rules(rules)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_rules!(rules.id) end
    end

    test "change_rules/1 returns a rules changeset" do
      rules = rules_fixture()
      assert %Ecto.Changeset{} = Accounts.change_rules(rules)
    end
  end
end
