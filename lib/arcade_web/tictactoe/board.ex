defmodule ArcadeWeb.TicTacToe.Board do
  use Phoenix.LiveComponent

  alias ArcadeWeb.TicTacToe

  @impl true
  def render(assigns) do
    ~L"""
    <style>
      div.column {cursor: pointer; text-align: center; height:50px;}
    </style>
    <div id="<%= @id %>">
      <%= for row <- 0..2 do %>
        <div class="row">
          <%= for col <- 1..3 do %>
            <%= live_component @socket, TicTacToe.Cell, index: row * 3 + col, value: @game.board[row * 3 + col], status: Arcade.Games.TicTacToe.status(@game) %>
          <% end %>
        </div>
      <% end %>
      <div class="row">
        <div class="column">
          <%= render_status(@game) %>
        </div>
      <div>
    </div>
    """
  end

  @impl true
  def handle_event("turn", %{"index" => value}, socket) do
    game = socket.assigns.game
    {index, _} = Integer.parse(value)

    new_game_state =
      game
      |> mark_cell(index, game.player)
      |> save

    # new_game_state =
    #   state
    #   |> Arcade.Games.update_tic_tac_toe(%{state: state})
    #   |> Arcade.Games.TicTacToe.load_from_changeset()

    {:noreply,
     assign(socket,
       index: value,
       game: new_game_state,
       status: Arcade.Games.TicTacToe.status(new_game_state)
     )}
  end

  defp save(game) do
    game
    |> Arcade.Games.update_tic_tac_toe(%{
      board: game.board,
      status: game.status,
      player: game.player
    })

    game
  end

  defp mark_cell(game, index, player), do: Arcade.Games.TicTacToe.mark(game, index, player)

  defp render_status(game) do
    case Arcade.Games.TicTacToe.status(game) do
      :in_progress ->
        "It's #{game.player}'s turn."

      :tie ->
        "It's a tie."

      {:complete, winner} ->
        " #{winner} wins!"
    end
  end
end
