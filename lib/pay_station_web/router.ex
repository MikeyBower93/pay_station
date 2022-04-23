defmodule PayStationWeb.Router do
  use PayStationWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PayStationWeb do
    pipe_through :api
  end
end
