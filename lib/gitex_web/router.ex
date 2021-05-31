defmodule GitexWeb.Router do
  use GitexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GitexWeb do
    pipe_through :api

    get "/github/:user/repos", GithubController, :index
  end
end
