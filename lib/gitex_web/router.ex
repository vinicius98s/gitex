defmodule GitexWeb.Router do
  use GitexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug GitexWeb.Auth.Pipeline
    plug GitexWeb.Auth.Plugs.RefreshToken
  end

  scope "/api", GitexWeb do
    pipe_through :api

    post "/users/", UsersController, :create
    post "/users/login", UsersController, :sign_in
  end

  scope "/api", GitexWeb do
    pipe_through [:api, :auth]

    get "/github/:user/repos", GithubController, :index
  end
end
