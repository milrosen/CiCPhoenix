defmodule CicFrontendWeb.ProofLive do
  alias CicFrontend.Accounts.User
  use CicFrontendWeb, :live_view
  alias CicFrontend.Proofs

  def mount(%{"id" => id}, _session, socket) do
    proof = Proofs.get_proof!(id)
    %User{:email => email} = CicFrontend.Accounts.get_user!(proof.user_id)
    {:ok, assign(socket, proof: proof, email: email)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    case Proofs.delete_proof(socket.assigns.current_user, id) do
      {:ok, _proof} ->
        socket = put_flash(socket, :info, "Proof Deleted. Gone")
        {:noreply, push_navigate(socket, to: ~p"/create")}

      {:error, message} ->
        {:noreply, put_flash(socket, :error, message)}
    end
  end
end
