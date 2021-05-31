defmodule Gitex.Repo do
  use Ecto.Repo,
    otp_app: :gitex,
    adapter: Ecto.Adapters.Postgres
end
