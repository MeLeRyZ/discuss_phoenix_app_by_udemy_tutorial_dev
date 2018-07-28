defmodule DiscussWeb.Plugs.RequireAuth do
    import Plug.Conn
    alias DiscussWeb.Router.Helpers
    import Phoenix.Controller

    def init(_params) do
    end

    def call(conn, _params) do
        if conn.assigns[:user] do
            conn #means everythiing is fine, go through
        else
            conn
            |> put_flash("error", "You must be loged in")
            |> redirect(to: Helpers.topic_path(conn, :index))
            |> halt() #cut off, and main controller go further now
        end
    end

end
