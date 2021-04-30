defmodule AsimovApiWeb.Router do
  use AsimovApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug AsimovApiWeb.Auth.Pipeline
    plug AsimovApiWeb.Auth.URLAuthorizer
  end

  scope "/api", AsimovApiWeb do
    pipe_through :api
    post "/users/signin", UsersController, :sign_in
  end

  scope "/api", AsimovApiWeb do
    pipe_through [:api, :auth]
    post "/users", UsersController, :create
    resources "/users", UsersController, only: [:show]
    resources "/scripts", ScriptsController, only: [:create]
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :asimov_api,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      schemes: ["http", "https"],
      info: %{
        version: "0.1",
        title: "AsimovAPI",
        description: "API Documentation for Asimov",
        termsOfService: "Open for public",
        contact: %{
          name: "Thiago Dornelles",
          email: "thiago.azevedo87@gmail.com"
        }
      },
      securityDefinitions: %{
        Bearer: %{
          type: "apiKey",
          name: "Authorization",
          description: "API Token must be provided via `Authorization: Bearer ` header",
          in: "header"
        }
      },
      consumes: ["application/json"],
      produces: ["application/json"]
    }
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: AsimovApiWeb.Telemetry
    end
  end
end
