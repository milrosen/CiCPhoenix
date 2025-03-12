defmodule CicFrontendWeb.DocumentChannel do
  use Phoenix.Channel

  def join("document:" <> _document_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("code_update", %{"body" => [_, [prog]]}, socket) do
    body =
      case CalculusOfConstructions.check(prog) do
        {:ok, proof} ->
          %{
            ok:
              Enum.map(
                proof,
                fn
                  {:error, errormsg} ->
                    errormsg

                  {:def, name, expr} ->
                    "def #{name} := #{PrettyPrint.printExpr(expr)}"

                  {:check, type} ->
                    PrettyPrint.printExpr(type)

                  {:eval, term, _} ->
                    "term evaluates to #{PrettyPrint.printExpr(term)}"
                end
              )
          }

        {:error, errmsg} ->
          %{error: errmsg}
      end

    broadcast!(socket, "type_check", %{body: body})
    {:noreply, socket}
  end
end
