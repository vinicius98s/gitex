ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Gitex.Repo, :manual)

Mox.defmock(Gitex.Github.ClientMock, for: Gitex.Clients)
