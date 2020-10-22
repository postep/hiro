defmodule SensorDbWeb.EventView do
  use SensorDbWeb, :view
  alias SensorDbWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      sensor: event.sensor,
      sensor_type: event.sensor_type,
      value: event.value}
  end
end
