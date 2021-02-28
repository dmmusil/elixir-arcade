defmodule TicTacToe.Board do
  use Phoenix.LiveComponent

  @impl true
  def render(assigns) do
    # ~L"""
    # <style>
    #   div.column {cursor: pointer; text-align: center; height:50px;}
    # </style>
    # <div id="<%= @id %>">
    #   <div class="row">
    #     <%= live_component @socket, TicTacToe.Cell, index: 1, value: @game.board[1] %>
    #     <%= live_component @socket, TicTacToe.Cell, index: 2, value: @game.board[2] %>
    #     <%= live_component @socket, TicTacToe.Cell, index: 3, value: @game.board[3] %>
    #   </div>
    #   <div class="row">
    #     <%= live_component @socket, TicTacToe.Cell, index: 4, value: @game.board[4] %>
    #     <%= live_component @socket, TicTacToe.Cell, index: 5, value: @game.board[5] %>
    #     <%= live_component @socket, TicTacToe.Cell, index: 6, value: @game.board[6] %>
    #   </div>
    #   <div class="row">
    #     <%= live_component @socket, TicTacToe.Cell, index: 7, value: @game.board[7] %>
    #     <%= live_component @socket, TicTacToe.Cell, index: 8, value: @game.board[8] %>
    #     <%= live_component @socket, TicTacToe.Cell, index: 9, value: @game.board[9] %>
    #   </div>
    #   <div class="row">
    #     <div class="column">
    #       <%= render_status(@status, @game.player) %>
    #     </div>
    #   <div>
    # </div>
    # """

    ~L"""
    <style>
      div.column {cursor: pointer; text-align: center; height:50px;}
    </style>
    <div id="<%= @id %>">
      <%= for row <- 0..2 do %>
        <div class="row">
          <%= for col <- 1..3 do %>
            <%= live_component @socket, TicTacToe.Cell, index: row * 3 + col, value: @game.board[row * 3 + col], status: @status %>
          <% end %>
        </div>
      <% end %>
      <div class="row">
        <div class="column">
          <%= render_status(@status, @game.player) %>
        </div>
      <div>
    </div>
    """
  end

  @impl true
  def handle_event("turn", %{"index" => value}, socket) do
    game = socket.assigns.game
    {index, _} = Integer.parse(value)
    new_game_state = game |> TicTacToe.Game.mark(index, game.player)

    {:noreply,
     assign(socket,
       index: value,
       game: new_game_state,
       status: TicTacToe.Game.status(new_game_state)
     )}
  end

  defp render_status(status, player) do
    case status do
      :in_progress ->
        "It's #{player}'s turn."

      :tie ->
        "It's a tie."

      {:complete, winner} ->
        " #{winner} wins!"
    end
  end
end
