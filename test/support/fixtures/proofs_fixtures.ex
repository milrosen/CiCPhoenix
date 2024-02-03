defmodule CicFrontend.ProofsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CicFrontend.Proofs` context.
  """

  @doc """
  Generate a proof.
  """
  def proof_fixture(attrs \\ %{}) do
    {:ok, proof} =
      attrs
      |> Enum.into(%{
        description: "some description",
        markup_text: "some markup_text",
        name: "some name"
      })
      |> CicFrontend.Proofs.create_proof()

    proof
  end

  @doc """
  Generate a saved_proof.
  """
  def saved_proof_fixture(attrs \\ %{}) do
    {:ok, saved_proof} =
      attrs
      |> Enum.into(%{})
      |> CicFrontend.Proofs.create_saved_proof()

    saved_proof
  end
end
