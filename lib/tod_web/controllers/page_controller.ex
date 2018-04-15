defmodule TODWeb.PageController do
  use TODWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def slack_webhook(conn, params) do
    IO.inspect params
    text conn, params["challenge"]
  end
end
