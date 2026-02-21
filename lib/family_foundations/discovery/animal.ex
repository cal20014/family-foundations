defmodule FamilyFoundations.Discovery.Animal do
  use Ecto.Schema
  import Ecto.Changeset

  # 1. Override the primary key to use the parent's ID
  @primary_key {:subject_id, :id, autogenerate: false}
  schema "animals" do
    field :scientific_name, :string
    field :diet_type, :string
    field :avg_weight_kg, :float
    field :avg_size_cm, :float

    # 2. Tell Ecto about the relationship without generating a duplicate field
    belongs_to :subject, FamilyFoundations.Discovery.Subject, define_field: false
    belongs_to :user, FamilyFoundations.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(animal, attrs, user_scope) do
    animal
    |> cast(attrs, [:subject_id, :scientific_name, :diet_type, :avg_weight_kg, :avg_size_cm])
    |> validate_required([
      :subject_id,
      :scientific_name,
      :diet_type,
      :avg_weight_kg,
      :avg_size_cm
    ])
    |> put_change(:user_id, user_scope.user.id)
  end
end
