defmodule TODWeb.Router do
  use TODWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TODWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/slack/webhook", PageController, :slack_webhook
  end

  # Other scopes may use custom stacks.
  # scope "/api", TODWeb do
  #   pipe_through :api
  # end
end
