defmodule FamilyFoundations.Discovery.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :common_name, :string

    # Relationships pointing "up"
    belongs_to :category, FamilyFoundations.Discovery.Category
    belongs_to :user, FamilyFoundations.Accounts.User

    # Relationships pointing "down" (Class Table Inheritance)
    has_one :animal, FamilyFoundations.Discovery.Animal
    has_one :color, FamilyFoundations.Discovery.Color
    has_one :shape, FamilyFoundations.Discovery.Shape

    has_many :media, FamilyFoundations.Discovery.MediaAsset

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(subject, attrs, user_scope) do
    subject
    |> cast(attrs, [:common_name, :category_id])
    |> validate_required([:common_name, :category_id])
    |> put_change(:user_id, user_scope.user.id)
  end
end
