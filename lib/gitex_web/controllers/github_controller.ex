defmodule GitexWeb.GithubController do
  use GitexWeb, :controller

  alias GitexWeb.Auth.Guardian
  alias GitexWeb.FallbackController

  action_fallback FallbackController

  def index(conn, params) do
    user = Map.get(params, "user")
    limit = Map.get(params, "limit")
    page = Map.get(params, "page")

    refresh_token = Guardian.Plug.current_token(conn)

    with {:ok, repos} <- client().get_repos(user, limit: limit, page: page) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos, refresh_token: refresh_token)
    end
  end

  def client do
    :gitex
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_adapter)
  end
end
