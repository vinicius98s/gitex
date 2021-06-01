defmodule GitexWeb.Auth.Plugs.RefreshToken do
  alias GitexWeb.Auth.Guardian

  def init(options), do: options

  def call(conn, _options) do
    case Guardian.Plug.authenticated?(conn) do
      true -> handle_refresh_token(conn)
      false -> conn
    end
  end

  defp handle_refresh_token(conn) do
    {:ok, _old_stuff, {new_token, _new_claims}} =
      conn
      |> Guardian.Plug.current_token()
      |> Guardian.refresh(ttl: {1, :minute})

    Guardian.Plug.put_current_token(conn, new_token)
  end
end
