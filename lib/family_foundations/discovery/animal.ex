defmodule FamilyFoundations.Discovery.Animal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animals" do
    field :scientific_name, :string
    field :diet_type, :string
    field :avg_weight_kg, :float
    field :avg_size_cm, :float
    field :subject_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(animal, attrs, user_scope) do
    animal
    |> cast(attrs, [:scientific_name, :diet_type, :avg_weight_kg, :avg_size_cm])
    |> validate_required([:scientific_name, :diet_type, :avg_weight_kg, :avg_size_cm])
    |> put_change(:user_id, user_scope.user.id)
  end
end
