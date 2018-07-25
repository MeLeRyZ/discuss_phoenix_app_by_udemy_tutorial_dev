defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  #users cont in db
  def change do 
    create table(:users) do
        add :email, :string
        add :provider, :string
        add :token, :string

        timestamps()
    end
  end

end
