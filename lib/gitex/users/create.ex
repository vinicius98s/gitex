defmodule Gitex.Users.Create do
  alias Gitex.{Error, Repo, User}

  def call(params) do
    changeset = User.changeset(params)

    case Repo.insert(changeset) do
      {:ok, %User{}} = result -> result
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end
