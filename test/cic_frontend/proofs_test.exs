defmodule CicFrontend.ProofsTest do
  use CicFrontend.DataCase

  alias CicFrontend.Proofs

  describe "proofs" do
    alias CicFrontend.Proofs.Proof

    import CicFrontend.ProofsFixtures

    @invalid_attrs %{name: nil, description: nil, markup_text: nil}

    test "list_proofs/0 returns all proofs" do
      proof = proof_fixture()
      assert Proofs.list_proofs() == [proof]
    end

    test "get_proof!/1 returns the proof with given id" do
      proof = proof_fixture()
      assert Proofs.get_proof!(proof.id) == proof
    end

    test "create_proof/1 with valid data creates a proof" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        markup_text: "some markup_text"
      }

      assert {:ok, %Proof{} = proof} = Proofs.create_proof(valid_attrs)
      assert proof.name == "some name"
      assert proof.description == "some description"
      assert proof.markup_text == "some markup_text"
    end

    test "create_proof/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Proofs.create_proof(@invalid_attrs)
    end

    test "update_proof/2 with valid data updates the proof" do
      proof = proof_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        markup_text: "some updated markup_text"
      }

      assert {:ok, %Proof{} = proof} = Proofs.update_proof(proof, update_attrs)
      assert proof.name == "some updated name"
      assert proof.description == "some updated description"
      assert proof.markup_text == "some updated markup_text"
    end

    test "update_proof/2 with invalid data returns error changeset" do
      proof = proof_fixture()
      assert {:error, %Ecto.Changeset{}} = Proofs.update_proof(proof, @invalid_attrs)
      assert proof == Proofs.get_proof!(proof.id)
    end

    test "delete_proof/1 deletes the proof" do
      proof = proof_fixture()
      assert {:ok, %Proof{}} = Proofs.delete_proof(proof)
      assert_raise Ecto.NoResultsError, fn -> Proofs.get_proof!(proof.id) end
    end

    test "change_proof/1 returns a proof changeset" do
      proof = proof_fixture()
      assert %Ecto.Changeset{} = Proofs.change_proof(proof)
    end
  end

  describe "saved_proofs" do
    alias CicFrontend.Proofs.SavedProof

    import CicFrontend.ProofsFixtures

    @invalid_attrs %{}

    test "list_saved_proofs/0 returns all saved_proofs" do
      saved_proof = saved_proof_fixture()
      assert Proofs.list_saved_proofs() == [saved_proof]
    end

    test "get_saved_proof!/1 returns the saved_proof with given id" do
      saved_proof = saved_proof_fixture()
      assert Proofs.get_saved_proof!(saved_proof.id) == saved_proof
    end

    test "create_saved_proof/1 with valid data creates a saved_proof" do
      valid_attrs = %{}

      assert {:ok, %SavedProof{} = saved_proof} = Proofs.create_saved_proof(valid_attrs)
    end

    test "create_saved_proof/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Proofs.create_saved_proof(@invalid_attrs)
    end

    test "update_saved_proof/2 with valid data updates the saved_proof" do
      saved_proof = saved_proof_fixture()
      update_attrs = %{}

      assert {:ok, %SavedProof{} = saved_proof} =
               Proofs.update_saved_proof(saved_proof, update_attrs)
    end

    test "update_saved_proof/2 with invalid data returns error changeset" do
      saved_proof = saved_proof_fixture()
      assert {:error, %Ecto.Changeset{}} = Proofs.update_saved_proof(saved_proof, @invalid_attrs)
      assert saved_proof == Proofs.get_saved_proof!(saved_proof.id)
    end

    test "delete_saved_proof/1 deletes the saved_proof" do
      saved_proof = saved_proof_fixture()
      assert {:ok, %SavedProof{}} = Proofs.delete_saved_proof(saved_proof)
      assert_raise Ecto.NoResultsError, fn -> Proofs.get_saved_proof!(saved_proof.id) end
    end

    test "change_saved_proof/1 returns a saved_proof changeset" do
      saved_proof = saved_proof_fixture()
      assert %Ecto.Changeset{} = Proofs.change_saved_proof(saved_proof)
    end
  end
end
