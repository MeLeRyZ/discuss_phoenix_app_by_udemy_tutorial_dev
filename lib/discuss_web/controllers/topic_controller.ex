defmodule DiscussWeb.TopicController do
    use DiscussWeb, :controller
    alias Discuss.Topic
    alias Discuss.Repo
    import Ecto #for build_assoc

    #exec only with certain actions
    plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

    def index(conn, _params) do
        topics = Repo.all(Topic)
        render conn, "index.html", topics: topics
    end

    def new(conn, _params) do
        changeset = Topic.changeset(%Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic }) do
        # con.assigns[:user] == conn.assigns.user
        #Ecto doc has info about assoc
        # old one -> changeset = Topic.changeset(%Topic{}, topic)
        # new one
        changeset = conn.assigns.user
            |> build_assoc(:topics) #matche up with schema
            |> Topic.changeset(topic)

        case Repo.insert(changeset)  do #saving to db
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Created")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset #no redirections
        end
    end

    def edit(conn, %{"id" => topic_id}) do
        topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic #for submitting the correct route topic_path(conn, update, 12)
    end

    def update(conn, %{"id" => topic_id, "topic" => topic}) do
        old_topic = Repo.get(Topic, topic_id)
        changeset =Topic.changeset(old_topic, topic)

        case Repo.update(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Updated")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "edit.html", changeset: changeset, topic: old_topic
        end
    end

    def delete(conn, %{"id" => topic_id}) do
        Repo.get!(Topic, topic_id) |> Repo.delete! #double touch db
        conn
        |> put_flash(:info, "Topic Deleted")
        |> redirect(to: topic_path(conn, :index))
    end

end
