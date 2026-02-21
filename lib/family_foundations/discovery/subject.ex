defmodule FamilyFoundations.Discovery.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :common_name, :string
    field :category_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(subject, attrs, user_scope) do
    subject
    |> cast(attrs, [:common_name])
    |> validate_required([:common_name])
    |> put_change(:user_id, user_scope.user.id)
  end
end
