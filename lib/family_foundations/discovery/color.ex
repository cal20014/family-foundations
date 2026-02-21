defmodule FamilyFoundations.Discovery.Color do
  use Ecto.Schema
  import Ecto.Changeset

  # 1. Override the primary key to use the parent's ID
  @primary_key {:subject_id, :id, autogenerate: false}
  schema "colors" do
    field :hex_code, :string
    field :rgb_value, :string

    # 2. Tell Ecto about the relationship without generating a duplicate field
    belongs_to :subject, FamilyFoundations.Discovery.Subject, define_field: false
    belongs_to :user, FamilyFoundations.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(color, attrs, user_scope) do
    color
    |> cast(attrs, [:subject_id, :hex_code, :rgb_value])
    |> validate_required([:subject_id, :hex_code, :rgb_value])
    |> put_change(:user_id, user_scope.user.id)
  end
end
