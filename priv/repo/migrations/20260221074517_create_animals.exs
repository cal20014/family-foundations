defmodule FamilyFoundations.Repo.Migrations.CreateAnimals do
  use Ecto.Migration

  def change do
    create table(:animals, primary_key: false) do
      add :subject_id, references(:subjects, on_delete: :delete_all), primary_key: true
      add :scientific_name, :string
      add :diet_type, :string
      add :avg_weight_kg, :float
      add :avg_size_cm, :float
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:animals, [:user_id])
    create index(:animals, [:subject_id])
  end
end
