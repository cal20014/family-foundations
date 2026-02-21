defmodule FamilyFoundations.Discovery.Color do
  use Ecto.Schema
  import Ecto.Changeset

  schema "colors" do
    field :hex_code, :string
    field :rgb_value, :string
    field :subject_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(color, attrs, user_scope) do
    color
    |> cast(attrs, [:hex_code, :rgb_value])
    |> validate_required([:hex_code, :rgb_value])
    |> put_change(:user_id, user_scope.user.id)
  end
end
