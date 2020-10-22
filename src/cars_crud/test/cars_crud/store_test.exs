defmodule CarsCrud.StoreTest do
  use CarsCrud.DataCase

  alias CarsCrud.Store

  describe "cars" do
    alias CarsCrud.Store.Cars

    @valid_attrs %{model: "some model", plates: "some plates", ttl: 120.5, vin: "some vin"}
    @update_attrs %{model: "some updated model", plates: "some updated plates", ttl: 456.7, vin: "some updated vin"}
    @invalid_attrs %{model: nil, plates: nil, ttl: nil, vin: nil}

    def cars_fixture(attrs \\ %{}) do
      {:ok, cars} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_cars()

      cars
    end

    test "list_cars/0 returns all cars" do
      cars = cars_fixture()
      assert Store.list_cars() == [cars]
    end

    test "get_cars!/1 returns the cars with given id" do
      cars = cars_fixture()
      assert Store.get_cars!(cars.id) == cars
    end

    test "create_cars/1 with valid data creates a cars" do
      assert {:ok, %Cars{} = cars} = Store.create_cars(@valid_attrs)
      assert cars.model == "some model"
      assert cars.plates == "some plates"
      assert cars.ttl == 120.5
      assert cars.vin == "some vin"
    end

    test "create_cars/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_cars(@invalid_attrs)
    end

    test "update_cars/2 with valid data updates the cars" do
      cars = cars_fixture()
      assert {:ok, %Cars{} = cars} = Store.update_cars(cars, @update_attrs)
      assert cars.model == "some updated model"
      assert cars.plates == "some updated plates"
      assert cars.ttl == 456.7
      assert cars.vin == "some updated vin"
    end

    test "update_cars/2 with invalid data returns error changeset" do
      cars = cars_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_cars(cars, @invalid_attrs)
      assert cars == Store.get_cars!(cars.id)
    end

    test "delete_cars/1 deletes the cars" do
      cars = cars_fixture()
      assert {:ok, %Cars{}} = Store.delete_cars(cars)
      assert_raise Ecto.NoResultsError, fn -> Store.get_cars!(cars.id) end
    end

    test "change_cars/1 returns a cars changeset" do
      cars = cars_fixture()
      assert %Ecto.Changeset{} = Store.change_cars(cars)
    end
  end
end
