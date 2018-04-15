defmodule TODWeb.Router do
  use TODWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", TODWeb do
    pipe_through [:browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/", TODWeb do
    # Use the default browser stack
    pipe_through :browser

    get "/", PageController, :index
    post "/slack/webhook", PageController, :slack_webhook

    resources "/accounts", AccountController, singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", TODWeb do
  #   pipe_through :api
  # end
end
