defmodule GitexWeb.GithubControllerTest do
  use GitexWeb.ConnCase, async: true

  import Mox
  import Gitex.Factory

  alias Gitex.Github.ClientMock
  alias Gitex.Error

  describe "index/2" do
    test "when given a valid user, returns the repo", %{conn: conn} do
      expect(ClientMock, :get_repos, fn _ -> {:ok, build_list(1, :github_repo)} end)

      user = "vinicius98s"

      response =
        conn
        |> get(Routes.github_path(conn, :index, user))
        |> json_response(:ok)

      assert %{
               "repos" => [
                 %{
                   "description" => nil,
                   "html_url" => "https://github.com/vinicius98s/testing",
                   "id" => 123,
                   "name" => "testing",
                   "stargazers_count" => 0
                 }
               ]
             } = response
    end

    test "when given an invalid user, returns an error", %{conn: conn} do
      expect(ClientMock, :get_repos, fn _ ->
        {:error, %Error{status: :not_found, result: "User repos not found"}}
      end)

      user = " "

      response =
        conn
        |> get(Routes.github_path(conn, :index, user))
        |> json_response(:not_found)

      assert %{"message" => "User repos not found"} = response
    end
  end
end
