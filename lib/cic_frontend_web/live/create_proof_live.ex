defmodule CicFrontendWeb.CreateProofLive do
  use CicFrontendWeb, :live_view
  import Phoenix.HTML.Form

  alias CicFrontend.{Proofs, Proofs.Proof}

  def mount(%{"id" => id}, _session, socket) do
    proof = Proofs.get_proof!(id)

    socket =
      assign(
        socket,
        form: to_form(Proofs.change_proof(proof)),
        proof: proof
      )

    {:ok, socket}
  end

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        form: to_form(Proofs.change_proof(%Proof{})),
        proof: %Proof{}
      )

    {:ok, socket}
  end

  def handle_event("save", %{"proof" => params}, socket) do
    case Proofs.update_or_insert_proof(socket.assigns.current_user, socket.assigns.proof, params) do
      {:ok, proof} ->
        {:noreply, push_navigate(socket, to: ~p"/proof?#{[id: proof]}")}

      {:error, msg} ->
        {:noreply, put_flash(socket, :error, msg)}
    end
  end

  def handle_event("validate", %{"proof" => params}, socket) do
    changeset =
      socket.assigns.proof
      |> Proofs.change_proof(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end
end
