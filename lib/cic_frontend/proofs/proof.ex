defmodule CicFrontend.Proofs.Proof do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "proofs" do
    field :name, :string
    field :description, :string
    field :markup_text, :string
    belongs_to :user, CicFrontend.Accounts.User
    has_many :comments, CicFrontend.Comments.Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(proof, attrs) do
    proof
    |> cast(attrs, [:name, :description, :markup_text, :user_id])
    |> validate_required([:name, :user_id])
  end
end
