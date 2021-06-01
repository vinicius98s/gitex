defmodule GitexWeb.UsersController do
  use GitexWeb, :controller

  alias Gitex.User
  alias Gitex.Users.Create
  alias GitexWeb.Auth.Guardian
  alias GitexWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user, token: token)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("token.json", token: token)
    end
  end
end
