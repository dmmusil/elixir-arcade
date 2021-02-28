defmodule TicTacToe.Game do
  defstruct board: %{}, player: "X"

  def new() do
    %TicTacToe.Game{board: Enum.reduce(1..9, %{}, fn i, acc -> Map.put(acc, i, nil) end)}
  end

  # If it's not the player's turn, don't let them mark
  def mark(%TicTacToe.Game{player: player} = game, _index, mark) when player != mark, do: game

  def mark(%TicTacToe.Game{} = game, index, mark) do
    case Map.get(game.board, index, -1) do
      nil ->
        %TicTacToe.Game{board: Map.put(game.board, index, mark), player: next_player(mark)}

      -1 ->
        raise "Invalid index"

      _ ->
        game
    end
  end

  def status(%TicTacToe.Game{board: game}) do
    case check_winner(game) do
      nil ->
        case Enum.all?(game, fn {_i, v} -> v != nil end) do
          true -> :tie
          _ -> :in_progress
        end

      winner ->
        {:complete, winner}
    end
  end

  def check_winner(game) do
    cond do
      check_row(game, 1) -> game[1]
      check_row(game, 2) -> game[4]
      check_row(game, 3) -> game[7]
      check_column(game, 1) -> game[1]
      check_column(game, 2) -> game[2]
      check_column(game, 3) -> game[3]
      check_diagonal(game, 1) -> game[1]
      check_diagonal(game, 2) -> game[3]
      true -> nil
    end
  end

  defp check_row(game, row) do
    offset = (row - 1) * 3 + 1

    game[offset] != nil && game[offset] == game[offset + 1] &&
      game[offset + 1] == game[offset + 2]
  end

  defp check_column(game, col) do
    game[col] != nil && game[col] == game[col + 3] && game[col + 3] == game[col + 6]
  end

  defp check_diagonal(game, diag) do
    case diag do
      1 -> game[1] != nil && game[1] == game[5] && game[5] == game[9]
      2 -> game[3] != nil && game[3] == game[5] && game[5] == game[7]
    end
  end

  defp next_player(player) do
    case player == "X" do
      true -> "O"
      false -> "X"
    end
  end
end
