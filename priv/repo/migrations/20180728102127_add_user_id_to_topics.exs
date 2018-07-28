defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration
  #not create a table but change an existing one
  def change do
      alter table(:topics) do
          add :user_id,  references(:users) #reference to anothertable in db
    end
  end
end
