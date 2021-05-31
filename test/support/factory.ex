defmodule Gitex.Factory do
  use ExMachina

  alias Gitex.Github.Repository

  def github_repo_factory do
    %Repository{
      id: 123,
      name: "testing",
      description: nil,
      html_url: "https://github.com/vinicius98s/testing",
      stargazers_count: 0
    }
  end
end
