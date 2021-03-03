defmodule ArcadeWeb.TicTacToeLive.FormComponent do
  use ArcadeWeb, :live_component

  alias Arcade.Games

  @impl true
  def update(%{tic_tac_toe: tic_tac_toe} = assigns, socket) do
    changeset = Games.change_tic_tac_toe(tic_tac_toe)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def handle_event("save", %{"tic_tac_toe" => tic_tac_toe_params}, socket) do
    save_tic_tac_toe(socket, socket.assigns.action, tic_tac_toe_params)
  end

  defp save_tic_tac_toe(socket, :edit, tic_tac_toe_params) do
    case Games.update_tic_tac_toe(socket.assigns.tic_tac_toe, tic_tac_toe_params) do
      {:ok, _tic_tac_toe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tic tac toe updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_tic_tac_toe(socket, :new, _tic_tac_toe_params) do
    case Games.create_tic_tac_toe() do
      {:ok, _tic_tac_toe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tic tac toe created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
