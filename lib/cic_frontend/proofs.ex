defmodule CicFrontend.Proofs do
  @moduledoc """
  The Proofs context.
  """

  import Ecto.Query, warn: false
  alias CicFrontend.Repo

  alias CicFrontend.Proofs.Proof

  @doc """
  Returns the list of proofs.

  ## Examples

      iex> list_proofs()
      [%Proof{}, ...]

  """
  def list_proofs do
    Repo.all(Proof)
  end

  @doc """
  Gets a single proof.

  Raises `Ecto.NoResultsError` if the Proof does not exist.

  ## Examples

      iex> get_proof!(123)
      %Proof{}

      iex> get_proof!(456)
      ** (Ecto.NoResultsError)

  """
  def get_proof!(id), do: Repo.get!(Proof, id)

  @doc """
  Creates a proof.

  ## Examples

      iex> create_proof(%{field: value})
      {:ok, %Proof{}}

      iex> create_proof(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_proof(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:proofs)
    |> Proof.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a proof.

  ## Examples

      iex> update_proof(proof, %{field: new_value})
      {:ok, %Proof{}}

      iex> update_proof(proof, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_proof(%Proof{} = proof, attrs) do
    proof
    |> Proof.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a proof.

  ## Examples

      iex> delete_proof(proof)
      {:ok, %Proof{}}

      iex> delete_proof(proof)
      {:error, %Ecto.Changeset{}}

  """
  def delete_proof(%Proof{} = proof) do
    Repo.delete(proof)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking proof changes.

  ## Examples

      iex> change_proof(proof)
      %Ecto.Changeset{data: %Proof{}}

  """
  def change_proof(%Proof{} = proof, attrs \\ %{}) do
    Proof.changeset(proof, attrs)
  end

  alias CicFrontend.Proofs.SavedProof

  @doc """
  Returns the list of saved_proofs.

  ## Examples

      iex> list_saved_proofs()
      [%SavedProof{}, ...]

  """
  def list_saved_proofs do
    Repo.all(SavedProof)
  end

  @doc """
  Gets a single saved_proof.

  Raises `Ecto.NoResultsError` if the Saved proof does not exist.

  ## Examples

      iex> get_saved_proof!(123)
      %SavedProof{}

      iex> get_saved_proof!(456)
      ** (Ecto.NoResultsError)

  """
  def get_saved_proof!(id), do: Repo.get!(SavedProof, id)

  @doc """
  Creates a saved_proof.

  ## Examples

      iex> create_saved_proof(%{field: value})
      {:ok, %SavedProof{}}

      iex> create_saved_proof(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_saved_proof(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:saved_proofs)
    |> SavedProof.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a saved_proof.

  ## Examples

      iex> update_saved_proof(saved_proof, %{field: new_value})
      {:ok, %SavedProof{}}

      iex> update_saved_proof(saved_proof, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_saved_proof(%SavedProof{} = saved_proof, attrs) do
    saved_proof
    |> SavedProof.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a saved_proof.

  ## Examples

      iex> delete_saved_proof(saved_proof)
      {:ok, %SavedProof{}}

      iex> delete_saved_proof(saved_proof)
      {:error, %Ecto.Changeset{}}

  """
  def delete_saved_proof(%SavedProof{} = saved_proof) do
    Repo.delete(saved_proof)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking saved_proof changes.

  ## Examples

      iex> change_saved_proof(saved_proof)
      %Ecto.Changeset{data: %SavedProof{}}

  """
  def change_saved_proof(%SavedProof{} = saved_proof, attrs \\ %{}) do
    SavedProof.changeset(saved_proof, attrs)
  end
end
