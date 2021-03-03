defmodule ArcadeWeb.TicTacToe.Cell do
  use Phoenix.LiveComponent

  def render(assigns) do
    complete =
      case assigns.status do
        :in_progress -> false
        _ -> true
      end

    print =
      case assigns.value do
        nil -> "_"
        _ -> assigns.value
      end

    case complete do
      true ->
        ~L"""
        <div class="column selected">
            <%= print %>
        </div>
        """

      false ->
        target = "#board-#{assigns.board_id}"

        ~L"""
        <div
          class="column"
          phx-click="turn"
          phx-value-index="<%= @index %>"
          phx-target="<%= target %>">
            <%= print %>
        </div>
        """
    end
  end
end
