defmodule FamilyFoundations.Repo.Migrations.CreateShapes do
  use Ecto.Migration

  def change do
    create table(:shapes, primary_key: false) do
      add :subject_id, references(:subjects, on_delete: :delete_all), primary_key: true
      add :sides_count, :integer
      add :is_2d, :boolean, default: false, null: false
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:shapes, [:user_id])
    create index(:shapes, [:subject_id])
  end
end
