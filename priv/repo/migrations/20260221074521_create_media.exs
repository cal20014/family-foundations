defmodule FamilyFoundations.Repo.Migrations.CreateMedia do
  use Ecto.Migration

  def change do
    create table(:media) do
      add :media_type, :string
      add :file_url, :string
      add :description, :string
      add :subject_id, references(:subjects, on_delete: :delete_all)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:media, [:user_id])

    create index(:media, [:subject_id])
  end
end
