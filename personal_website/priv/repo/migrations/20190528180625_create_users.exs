defmodule PersonalWebsite.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :encrypted_password, :string

      timestamps()
    end
  
  end
end
