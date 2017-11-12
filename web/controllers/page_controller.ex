defmodule PhoenixTodo.PageController do
  use PhoenixTodo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
