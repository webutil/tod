defmodule TOD.DB do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    :db_repos =
      :ets.new(:db_repos, [
        :named_table,
        :public,
        :bag,
        {:write_concurrency, true},
        {:read_concurrency, true}
      ])

    {:ok, state}
  end

  def insert_repo(%{name: name, access_token: token}) do
    :ets.insert(:db_repos, {name, token})
  end

  def find_repo(name) do
    case :ets.lookup(:db_repos, name) do
      [] -> {:error, :not_found}
      [{name, token}] -> {:ok, %{name: name, access_token: token}}
    end
  end
end
