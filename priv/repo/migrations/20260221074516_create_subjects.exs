defmodule FamilyFoundations.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :common_name, :string
      add :category_id, references(:categories, on_delete: :nothing)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:subjects, [:user_id])

    create index(:subjects, [:category_id])
  end
end
