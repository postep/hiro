defmodule CarsCrudWeb.CarsController do
  use CarsCrudWeb, :controller

  alias CarsCrud.Store
  alias CarsCrud.Store.Cars

  action_fallback CarsCrudWeb.FallbackController

  def index(conn, _params) do
    cars = Store.list_cars()
    render(conn, "index.json", cars: cars)
  end

  def create(conn, %{"cars" => cars_params}) do
    with {:ok, %Cars{} = cars} <- Store.create_cars(cars_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cars_path(conn, :show, cars))
      |> render("show.json", cars: cars)
    end
  end

  def show(conn, %{"id" => id}) do
    cars = Store.get_cars!(id)
    render(conn, "show.json", cars: cars)
  end

  def update(conn, %{"id" => id, "cars" => cars_params}) do
    cars = Store.get_cars!(id)

    with {:ok, %Cars{} = cars} <- Store.update_cars(cars, cars_params) do
      render(conn, "show.json", cars: cars)
    end
  end

  def delete(conn, %{"id" => id}) do
    cars = Store.get_cars!(id)

    with {:ok, %Cars{}} <- Store.delete_cars(cars) do
      send_resp(conn, :no_content, "")
    end
  end
end
