defmodule PhoenixTodo.UserController do
  use PhoenixTodo.Web, :controller
  alias PhoenixTodo.User

  require Logger

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> PhoenixTodo.Auth.login(user)
        |> put_flash(:info, "User created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->

        IO.inspect changeset

        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user)
    render(conn, "show.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.registration_changeset(user, user_params)

    case Repo.update(changeset) do
      { :ok, user } ->
        conn
        |> put_flash(:info, "User updated")
        |> redirect(to: user_path(conn, :index))
      { :error, changeset } ->
        conn
        |> render("show.html", user: user, changeset: changeset)
    end
  end

end
