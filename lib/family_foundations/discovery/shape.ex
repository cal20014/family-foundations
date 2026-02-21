defmodule FamilyFoundations.Discovery.Shape do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shapes" do
    field :sides_count, :integer
    field :is_2d, :boolean, default: false
    field :subject_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(shape, attrs, user_scope) do
    shape
    |> cast(attrs, [:sides_count, :is_2d])
    |> validate_required([:sides_count, :is_2d])
    |> put_change(:user_id, user_scope.user.id)
  end
end
