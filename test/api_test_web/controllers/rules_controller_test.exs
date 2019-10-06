defmodule ApiTestWeb.RulesControllerTest do
  use ApiTestWeb.ConnCase

  alias ApiTest.Accounts
  alias ApiTest.Accounts.Rules

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:rules) do
    {:ok, rules} = Accounts.create_rules(@create_attrs)
    rules
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rules", %{conn: conn} do
      conn = get(conn, Routes.rules_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rules" do
    test "renders rules when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rules_path(conn, :create), rules: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.rules_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rules_path(conn, :create), rules: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rules" do
    setup [:create_rules]

    test "renders rules when data is valid", %{conn: conn, rules: %Rules{id: id} = rules} do
      conn = put(conn, Routes.rules_path(conn, :update, rules), rules: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.rules_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, rules: rules} do
      conn = put(conn, Routes.rules_path(conn, :update, rules), rules: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete rules" do
    setup [:create_rules]

    test "deletes chosen rules", %{conn: conn, rules: rules} do
      conn = delete(conn, Routes.rules_path(conn, :delete, rules))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.rules_path(conn, :show, rules))
      end
    end
  end

  defp create_rules(_) do
    rules = fixture(:rules)
    {:ok, rules: rules}
  end
end
