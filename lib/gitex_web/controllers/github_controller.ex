defmodule GitexWeb.GithubController do
  use GitexWeb, :controller

  alias GitexWeb.FallbackController

  action_fallback FallbackController

  def index(conn, params) do
    user = Map.get(params, "user")
    limit = Map.get(params, "limit")
    page = Map.get(params, "page")

    with {:ok, repos} <- client().get_repos(user, limit: limit, page: page) do
      conn
      |> put_status(:ok)
      |> render("github_repos.json", repos: repos)
    end
  end

  def client do
    :gitex
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_adapter)
  end
end
