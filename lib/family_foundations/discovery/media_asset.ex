defmodule FamilyFoundations.Discovery.MediaAsset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "media" do
    field :media_type, :string
    field :file_url, :string
    field :description, :string
    belongs_to :subject, FamilyFoundations.Discovery.Subject
    belongs_to :user, FamilyFoundations.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(media_asset, attrs, user_scope) do
    media_asset
    |> cast(attrs, [:media_type, :file_url, :description])
    |> validate_required([:media_type, :file_url, :description])
    |> put_change(:user_id, user_scope.user.id)
  end
end
