defmodule TOD.Repo do
  alias __MODULE__
  defstruct [:owner, :name, :sha, :files]

  import Logger, only: [info: 1]

  def full_name(%Repo{name: name, owner: owner} = _repo), do: [owner, name] |> Enum.join("/")

  def update_cache(%Repo{} = repo, client) do
    sha = latest_sha(repo, client)

    if repo.sha == sha do
      info("#{full_name(repo)} hasn't changed sha is still at #{sha}")
      :ok
    else
      files = contents(repo, client)
      %{repo | files: files, sha: sha}
    end
  end

  def contents(%Repo{} = repo, client) do
    info("getting contents for #{full_name(repo)}")
    get_contents(repo, [""], [], client)
  end

  def latest_sha(%Repo{} = repo, client) do
    {200, info, _} = Tentacat.Repositories.Branches.find(repo.owner, repo.name, "master", client)
    info["commit"]["sha"]
  end

  def get_contents(_repo, [], files_acc, _client), do: files_acc

  def get_contents(repo, [dir | rest_dirs], files_acc, client) do
    info("getting contents of #{full_name(repo)} for dir: #{dir}")
    {200, ls, _} = Tentacat.Contents.find(repo.owner, repo.name, dir, client)

    file_dirs = ls |> Enum.group_by(fn x -> x["type"] end)

    dirs = (file_dirs["dir"] || []) |> Enum.map(fn x -> x["path"] end)
    files = file_dirs["file"] || []

    get_contents(repo, rest_dirs ++ dirs, files_acc ++ files, client)
  end
end
