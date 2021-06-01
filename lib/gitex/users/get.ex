defmodule Gitex.Users.Get do
  alias Gitex.{Error, Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      user -> {:ok, user}
    end
  end
end
