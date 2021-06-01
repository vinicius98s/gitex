defmodule Gitex.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :password_hash, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
