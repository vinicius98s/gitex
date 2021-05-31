defmodule Gitex.Github.Client do
  use Tesla

  plug Tesla.Middleware.Headers, [{"user-agent", "elixir"}]
  plug Tesla.Middleware.JSON

  alias Tesla.Env

  alias Gitex.{Error, Clients}
  alias Gitex.Github.Repository

  @behaviour Clients

  @base_url "https://api.github.com/"
  @default_options [
    limit: 30,
    page: 1
  ]

  def get_repos(user, options) when is_list(options) do
    handle_url_request(@base_url, options, user)
  end

  def get_repos(user, url \\ @base_url, options \\ @default_options) do
    handle_url_request(url, options, user)
  end

  defp handle_url_request(url, options, user) do
    url_params = build_url_params(options)

    case get("#{url}users/#{user}/repos#{url_params}") do
      {:ok, %Env{status: 200, body: body}} ->
        {:ok, Enum.map(body, &Repository.build/1)}

      {:ok, _} ->
        {:error, Error.build(:not_found, "User repos not found")}

      {:error, reason} ->
        {:error, Error.build(:internal_server_error, reason)}
    end
  end

  def build_url_params(options) do
    built_options = Keyword.merge(@default_options, options)
    limit = Keyword.get(built_options, :limit)
    page = Keyword.get(built_options, :page)

    "?per_page=#{limit}&page=#{page}"
  end
end
