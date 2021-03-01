defmodule ArcadeWeb.TicTacToeLive.Show do
  use ArcadeWeb, :live_view

  alias Arcade.Games

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:tic_tac_toe, Games.get_tic_tac_toe!(id))}
  end

  defp page_title(:show), do: "Show Tic tac toe"
  defp page_title(:edit), do: "Edit Tic tac toe"
end
