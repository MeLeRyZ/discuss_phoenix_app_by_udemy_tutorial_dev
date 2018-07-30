defmodule DiscussWeb.CommentsChannel do
    use DiscussWeb, :channel
    alias Discuss.{Topic, Repo, Comment}
    import Ecto #for build_assoc

    def join("comments:" <> topic_id, _params, socket) do #socket obj is eq to conn obj
        #topic_id = String.to_integer(topic_id)
        topic = Topic
            |> Repo.get(topic_id)
            |> Repo.preload(:comments) #load up the assoc

        {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
    end

    def handle_in(name, %{"content" => content}, socket) do
        topic = socket.assigns.topic

        changeset = topic
            |> build_assoc(:comments)
            |> Comment.changeset(%{content: content})

        case Repo.insert(changeset) do
            {:ok, comment} ->
                {:reply, :ok, socket}
            {:error, _reason} ->
                {:reply, {:error, %{errors: changeset}}, socket}
        end
    end
end
