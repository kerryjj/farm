defmodule FarmWeb.Router do
  use FarmWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FarmWeb.Api do
    pipe_through :api
  end
end
