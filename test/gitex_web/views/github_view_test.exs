defmodule GitexWeb.GithubViewTest do
  use GitexWeb.ConnCase, async: true

  import Phoenix.View
  import Gitex.Factory

  alias GitexWeb.GithubView
  alias Gitex.Github.Repository

  test "renders github_repo.json" do
    repos = build_list(1, :github_repo)

    response = render(GithubView, "github_repos.json", repos: repos)

    assert %{
             repos: [
               %Repository{
                 description: nil,
                 html_url: "https://github.com/vinicius98s/testing",
                 id: 123,
                 name: "testing",
                 stargazers_count: 0
               }
             ]
           } = response
  end
end
