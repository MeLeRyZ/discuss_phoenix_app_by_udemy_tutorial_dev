defmodule Discuss.Comment do
    use Ecto.Schema
    import Ecto.Changeset

    @derive {Poison.Encoder, only: [:content, :user]} #NEED restart server

    schema "comments" do
        field :content, :string
        belongs_to :user, Discuss.User
        belongs_to :topic, Discuss.Topic

        timestamps()
    end

#same as earlier
    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:content])
        |> validate_required([:content])
    end
end
