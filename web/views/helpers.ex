defmodule PhoenixTodo.ViewHelper do
  def current_user(conn), do: Guardian.Plug.current_resoure(conn)
  def logged_in?(conn), do: Guardian.Plug.authenticated?(conn)
end