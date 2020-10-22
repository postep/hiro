defmodule SensorDb.StoreTest do
  use SensorDb.DataCase

  alias SensorDb.Store

  describe "events" do
    alias SensorDb.Store.Event

    @valid_attrs %{sensor: "some sensor", sensor_type: "some sensor_type", value: 120.5}
    @update_attrs %{sensor: "some updated sensor", sensor_type: "some updated sensor_type", value: 456.7}
    @invalid_attrs %{sensor: nil, sensor_type: nil, value: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Store.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Store.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Store.create_event(@valid_attrs)
      assert event.sensor == "some sensor"
      assert event.sensor_type == "some sensor_type"
      assert event.value == 120.5
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Store.update_event(event, @update_attrs)
      assert event.sensor == "some updated sensor"
      assert event.sensor_type == "some updated sensor_type"
      assert event.value == 456.7
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_event(event, @invalid_attrs)
      assert event == Store.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Store.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Store.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Store.change_event(event)
    end
  end
end
