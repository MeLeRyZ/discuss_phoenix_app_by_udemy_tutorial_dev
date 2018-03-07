defmodule DiscussWeb.TopicController do
    use DiscussWeb, :controller
    alias Discuss.Topic
    alias Discuss.Repo

    def new(conn, params) do
        changeset = Topic.changeset(%Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic }) do
        changeset = Topic.changeset(%Topic{}, topic)

        case Repo.insert(changeset)  do #saving to db
            {:ok, post} -> IO.inspect(post)
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end
    end
end
