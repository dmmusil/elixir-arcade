defmodule ArcadeWeb.PageLive do
  use ArcadeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    game = Arcade.Games.TicTacToe.new()
    {:ok, assign(socket, game: game)}
  end
end
