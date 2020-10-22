defmodule CarsCrudWeb.CarsControllerTest do
  use CarsCrudWeb.ConnCase

  alias CarsCrud.Store
  alias CarsCrud.Store.Cars

  @create_attrs %{
    model: "some model",
    plates: "some plates",
    ttl: 120.5,
    vin: "some vin"
  }
  @update_attrs %{
    model: "some updated model",
    plates: "some updated plates",
    ttl: 456.7,
    vin: "some updated vin"
  }
  @invalid_attrs %{model: nil, plates: nil, ttl: nil, vin: nil}

  def fixture(:cars) do
    {:ok, cars} = Store.create_cars(@create_attrs)
    cars
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cars", %{conn: conn} do
      conn = get(conn, Routes.cars_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cars" do
    test "renders cars when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cars_path(conn, :create), cars: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.cars_path(conn, :show, id))

      assert %{
               "id" => id,
               "model" => "some model",
               "plates" => "some plates",
               "ttl" => 120.5,
               "vin" => "some vin"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cars_path(conn, :create), cars: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cars" do
    setup [:create_cars]

    test "renders cars when data is valid", %{conn: conn, cars: %Cars{id: id} = cars} do
      conn = put(conn, Routes.cars_path(conn, :update, cars), cars: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.cars_path(conn, :show, id))

      assert %{
               "id" => id,
               "model" => "some updated model",
               "plates" => "some updated plates",
               "ttl" => 456.7,
               "vin" => "some updated vin"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cars: cars} do
      conn = put(conn, Routes.cars_path(conn, :update, cars), cars: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cars" do
    setup [:create_cars]

    test "deletes chosen cars", %{conn: conn, cars: cars} do
      conn = delete(conn, Routes.cars_path(conn, :delete, cars))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.cars_path(conn, :show, cars))
      end
    end
  end

  defp create_cars(_) do
    cars = fixture(:cars)
    %{cars: cars}
  end
end
