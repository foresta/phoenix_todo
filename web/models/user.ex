defmodule PhoenixTodo.User do
  use PhoenixTodo.Web, :model

  require Logger

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(email), [])
    |> validate_format(:email, ~r/@/)
    |> validate_required([:email])
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> validate_required(:password)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
  
    Logger.info "put_password_hash"

    IO.inspect changeset
    
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
