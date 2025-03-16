defmodule CicFrontendWeb.DocumentChannel do
  use Phoenix.Channel

  def join("document:" <> _document_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("code_update", %{"body" => progs}, socket) do
    body =
      Enum.map(
        progs,
        fn prog ->
          case CalculusOfConstructions.check(prog) do
            {:error, errmsg} ->
              %{error: errmsg}

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

                      {:type, type} ->
                        PrettyPrint.printExpr(type)

                      {:eval, term, _} ->
                        "term evaluates to #{PrettyPrint.printExpr(term)}"

                      {:with, _} ->
                        "TODO: Print Context"

                      {:check, name, type, term} ->
                        "#{name} : #{PrettyPrint.printExpr(type)} = #{PrettyPrint.printExpr(term)}"
                    end
                  )
              }
          end
        end
      )

    broadcast!(socket, "type_check", %{body: body})
    {:noreply, socket}
  end
end
