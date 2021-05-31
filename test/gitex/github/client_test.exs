defmodule Gitex.Github.ClientTest do
  use ExUnit.Case, async: true

  import Gitex.Factory

  alias Gitex.Github.Client
  alias Gitex.Error

  alias Plug.Conn

  describe "get_repos/2" do
    setup do
      bypass = Bypass.open()

      url = "http://localhost:#{bypass.port}/"

      {:ok, bypass: bypass, url: url}
    end

    test "when given a valid user, returns the repositories", %{bypass: bypass, url: url} do
      user = "vinicius98s"

      body = ~s([{
        "id": 123,
        "name": "testing",
        "description": null,
        "html_url": "https://github.com/vinicius98s/testing",
        "stargazers_count": 0
      }])

      Bypass.expect(bypass, "GET", "users/#{user}/repos", fn conn ->
        conn
        |> Conn.put_resp_content_type("application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_repos(user, url)

      expected_response = {:ok, build_list(1, :github_repo)}

      assert response == expected_response
    end

    test "when given an invalid user, returns an error", %{bypass: bypass, url: url} do
      user = ""

      Bypass.expect(bypass, "GET", "users/#{user}/repos", fn conn ->
        Conn.resp(conn, 404, "")
      end)

      response = Client.get_repos(user, url)

      expected_response = {:error, %Error{status: :not_found, result: "User repos not found"}}

      assert response == expected_response
    end
  end
end
