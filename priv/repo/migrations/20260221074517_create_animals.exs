defmodule FamilyFoundations.Repo.Migrations.CreateAnimals do
  use Ecto.Migration

  def change do
    create table(:animals) do
      add :scientific_name, :string
      add :diet_type, :string
      add :avg_weight_kg, :float
      add :avg_size_cm, :float
      add :subject_id, references(:subjects, on_delete: :nothing)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:animals, [:user_id])

    create index(:animals, [:subject_id])
  end
end
