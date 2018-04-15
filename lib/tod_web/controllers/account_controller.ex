defmodule TODWeb.AccountController do
  use TODWeb, :controller
  alias TOD.DB

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"account" => account_params}) do
    DB.insert_repo(%{name: account_params["github_url"], access_token: "test"})
    render(conn, :new)
  end
end
