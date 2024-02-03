defmodule CicFrontend.Proofs.SavedProof do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "saved_proofs" do
    belongs_to :user, CicFrontend.Accounts.User
    belongs_to :proof, CicFrontend.Proofs.Proof

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(saved_proof, attrs) do
    saved_proof
    |> cast(attrs, [:user_id, :gist_id])
    |> validate_required([:user_id, :gist_id])
  end
end
