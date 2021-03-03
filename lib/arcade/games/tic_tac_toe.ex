defmodule Arcade.Games.TicTacToe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tictactoe" do
    field :board, :map
    field :status, :string
    field :player, :string

    timestamps()
  end

  @doc false
  def changeset(tic_tac_toe, attrs) do
    tic_tac_toe
    |> cast(attrs, [:board, :status, :player])
    |> validate_required([:board, :status, :player])
  end

  def new() do
    %Arcade.Games.TicTacToe{
      board: Enum.reduce(1..9, %{}, fn i, acc -> Map.put(acc, i, nil) end),
      status: Atom.to_string(:in_progress),
      player: "X"
    }
  end

  # If it's not the player's turn, don't let them mark
  def mark(%Arcade.Games.TicTacToe{player: player} = game, _index, mark) when player != mark do
    game
  end

  def mark(%Arcade.Games.TicTacToe{} = game, index, mark) do
    case Map.get(game.board, index, -1) do
      nil ->
        %Arcade.Games.TicTacToe{
          game
          | board: Map.put(game.board, index, mark),
            player: next_player(mark),
            status: status(game)
        }

      -1 ->
        raise "Invalid index"

      _ ->
        game
    end
  end

  def status(%Arcade.Games.TicTacToe{board: game}) do
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

  defp parse_map_keys(map) do
    Enum.into(map, %{}, fn {k, v} ->
      {int_key, _} = Integer.parse(k)
      {int_key, v}
    end)
  end

  def check_winner(game) do
    game = parse_map_keys(game)

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

  defp check_diagonal(game, diag) when diag == 1,
    do: game[1] != nil && game[1] == game[5] && game[5] == game[9]

  defp check_diagonal(game, diag) when diag == 2,
    do: game[3] != nil && game[3] == game[5] && game[5] == game[7]

  defp next_player(player) when player == "X", do: "O"
  defp next_player(player) when player == "O", do: "X"
end
