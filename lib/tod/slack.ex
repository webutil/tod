defmodule TOD.Slack do
  def send_message(text, webhook_url) do
    case HTTPoison.post(
           webhook_url,
           Jason.encode!(%{
             text: text
           }),
           [{"content-type", "application/json"}]
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      err -> {:error, err}
    end
  end
end
