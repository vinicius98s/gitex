defmodule GitexWeb.UsersView do
  use GitexWeb, :view

  def render("token.json", %{token: token}), do: %{token: token}

  def render("user.json", %{user: user, token: token}), do: %{user: user, token: token}
end
