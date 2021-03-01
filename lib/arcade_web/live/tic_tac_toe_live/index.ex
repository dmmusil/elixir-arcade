defmodule ArcadeWeb.TicTacToeLive.Index do
  use ArcadeWeb, :live_view

  alias Arcade.Games
  alias Arcade.Games.TicTacToe

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       tictactoe: list_tictactoe(),
       game: Arcade.Games.TicTacToe.new(),
       status: :in_progress
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tic tac toe")
    |> assign(:tic_tac_toe, Games.get_tic_tac_toe!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tic tac toe")
    |> assign(:tic_tac_toe, %TicTacToe{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tictactoe")
    |> assign(:tic_tac_toe, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tic_tac_toe = Games.get_tic_tac_toe!(id)
    {:ok, _} = Games.delete_tic_tac_toe(tic_tac_toe)

    {:noreply, assign(socket, :tictactoe, list_tictactoe())}
  end

  defp list_tictactoe do
    Games.list_tictactoe()
  end
end
