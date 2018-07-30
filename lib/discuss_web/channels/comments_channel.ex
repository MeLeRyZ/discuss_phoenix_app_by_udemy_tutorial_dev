defmodule DiscussWeb.CommentsChannel do
    use DiscussWeb, :channel

    def join(name, _params, socket) do #socket obj is eq to conn obj
        IO.puts(name)
        {:ok, %{hey: "there"}, socket}
    end

    def handle_in(name, message, socket) do
        {:reply, :ok, socket}
    end
end
