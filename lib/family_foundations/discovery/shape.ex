defmodule FamilyFoundations.Discovery.Shape do
  use Ecto.Schema
  import Ecto.Changeset

  # 1. Override the primary key to use the parent's ID
  @primary_key {:subject_id, :id, autogenerate: false}
  schema "shapes" do
    field :sides_count, :integer
    field :is_2d, :boolean, default: false

    # 2. Tell Ecto about the relationship without generating a duplicate field
    belongs_to :subject, FamilyFoundations.Discovery.Subject, define_field: false
    belongs_to :user, FamilyFoundations.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(shape, attrs, user_scope) do
    shape
    |> cast(attrs, [:subject_id, :sides_count, :is_2d])
    |> validate_required([:subject_id, :sides_count, :is_2d])
    |> put_change(:user_id, user_scope.user.id)
  end
end
