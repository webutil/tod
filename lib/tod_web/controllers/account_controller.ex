defmodule TODWeb.AccountController do
  use TODWeb, :controller

  def new(conn, _params) do
    render conn, :new
  end
end
