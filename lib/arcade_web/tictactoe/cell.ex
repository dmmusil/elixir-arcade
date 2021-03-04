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
        nil -> ""
        _ -> assigns.value
      end

    case complete do
      true ->
        ~L"""
        <td class="selected">
            <%= print %>
        </td>
        """

      false ->
        target = "#board-#{assigns.board_id}"

        ~L"""
        <td
          phx-click="turn"
          phx-value-index="<%= @index %>"
          phx-target="<%= target %>">
            <%= print %>
        </td>
        """
    end
  end
end
