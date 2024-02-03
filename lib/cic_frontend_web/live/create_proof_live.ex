defmodule CicFrontendWeb.CreateProofLive do
  use CicFrontendWeb, :live_view
  import Phoenix.HTML.Form

  alias CicFrontend.{Proofs, Proofs.Proof}

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        form: to_form(Proofs.change_proof(%Proof{}))
      )

    {:ok, socket}
  end

  def handle_event("create", %{"proof" => params}, socket) do
    case Proofs.create_proof(socket.assigns.current_user, params) do
      {:ok, proof} ->
        socket = push_event(socket, "clear-textarea", %{})
        # blanks the inputs - change this
        changeset = Proofs.change_proof(%Proof{})
        socket = assign(socket, :form, to_form(changeset))

        {:noreply, push_navigate(socket, to: ~p"/proof?#{[id: proof]}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  def handle_event("validate", %{"proof" => params}, socket) do
    changeset =
      %Proof{}
      |> Proofs.change_proof(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end
end
