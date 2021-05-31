defmodule Gitex.Clients do
  alias Gitex.Error

  @callback get_repos(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
