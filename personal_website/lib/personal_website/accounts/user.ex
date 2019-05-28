defmodule PersonalWebsite.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> generate_encrypted_password()
  end



  defp generate_encrypted_password ( changeset = %Ecto.Changeset{valid?: true}) do
    password = get_change(changeset,:password)
    put_change(changeset, :encrypted_password, Bcrypt.hash_pwd_salt(password))
  end 

  defp generate_encrypted_password ( changeset ) do
    changeset
  end
end
