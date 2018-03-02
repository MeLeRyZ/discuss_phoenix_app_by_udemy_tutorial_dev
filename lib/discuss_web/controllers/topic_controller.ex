defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller #we use 'use' cause... fancy

  def new(conn, params) do
    IO.puts "+++++"
    IO.inspect conn
    IO.puts "+++++"
    IO.inspect params
    IO.puts "+++++"
    IO.puts "Atom testing for github"
  end
end
