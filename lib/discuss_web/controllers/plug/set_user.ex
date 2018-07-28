defmodule DiscussWeb.Plugs.SetUser do
    import Plug.Conn
    #import Phoenix.Controller

    alias Discuss.Repo
    alias Discuss.User
    #alias Discuss.Router.Helpers
    #grab user id, fetch db, tiny transforms

    def init(_params) do
    end

    def call(conn, _params) do
        user_id = get_session(conn, :user_id)

        cond do
            user = user_id && Repo.get(User, user_id) -> #red = 1&& "red" -> res == "red", assign second element
                assign(conn, :user, user)
                # conn.assigns.user => user struct
            true ->
                assign(conn, :user, nil)
        end
    end

end
