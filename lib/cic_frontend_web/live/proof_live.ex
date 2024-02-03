defmodule CicFrontendWeb.ProofLive do
  use CicFrontendWeb, :live_view
  alias CicFrontend.Proofs

  def mount(%{"id" => id}, _session, socket) do
    proof = Proofs.get_proof!(id)
    {:ok, assign(socket, proof: proof)}
  end
end
