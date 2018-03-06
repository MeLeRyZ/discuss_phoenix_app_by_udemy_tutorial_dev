defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  action_fallback DiscussWeb.FallbackController

  def index(conn, _params) do
    topic = Discuss.list_topic()
    render(conn, "index.json", topic: topic)
  end

  def create(conn, %{"topic" => topic_params}) do
    with {:ok, %Topic{} = topic} <- Discuss.create_topic(topic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", topic_path(conn, :show, topic))
      |> render("show.json", topic: topic)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Discuss.get_topic!(id)
    render(conn, "show.json", topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Discuss.get_topic!(id)

    with {:ok, %Topic{} = topic} <- Discuss.update_topic(topic, topic_params) do
      render(conn, "show.json", topic: topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Discuss.get_topic!(id)
    with {:ok, %Topic{}} <- Discuss.delete_topic(topic) do
      send_resp(conn, :no_content, "")
    end
  end
end
