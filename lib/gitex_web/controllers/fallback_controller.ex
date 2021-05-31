defmodule GitexWeb.FallbackController do
  use GitexWeb, :controller

  alias Gitex.Error
  alias GitexWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
