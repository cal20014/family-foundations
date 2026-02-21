defmodule FamilyFoundations.Repo.Migrations.CreateColors do
  use Ecto.Migration

  def change do
    create table(:colors) do
      add :hex_code, :string
      add :rgb_value, :string
      add :subject_id, references(:subjects, on_delete: :nothing)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:colors, [:user_id])

    create index(:colors, [:subject_id])
  end
end
