defmodule GitexWeb.GithubView do
  use GitexWeb, :view

  def render("repos.json", %{repos: repos, refresh_token: refresh_token}),
    do: %{repos: repos, refresh_token: refresh_token}
end
