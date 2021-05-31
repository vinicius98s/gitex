defmodule GitexWeb.GithubView do
  use GitexWeb, :view

  def render("github_repos.json", %{repos: repos}), do: %{repos: repos}
end
