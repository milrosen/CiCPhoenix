defmodule CicFrontend.Repo.Migrations.CreateSavedProofs do
  use Ecto.Migration

  def change do
    create table(:saved_proofs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :proof_id, references(:proofs, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:saved_proofs, [:user_id])
    create index(:saved_proofs, [:proof_id])
  end
end
