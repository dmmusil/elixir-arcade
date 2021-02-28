defmodule TicTacToe.Game.Tests do
  use ExUnit.Case

  alias TicTacToe.Game

  test "new game has 9 empty cells" do
    assert %Game{
             board: %{
               1 => nil,
               2 => nil,
               3 => nil,
               4 => nil,
               5 => nil,
               6 => nil,
               7 => nil,
               8 => nil,
               9 => nil
             }
           } == Game.new()
  end

  test "mark a cell" do
    game = Game.new()

    assert Game.mark(game, 1, "X") == %Game{
             board: Map.put(game.board, 1, "X"),
             player: "O"
           }
  end

  test "cannot remark a cell" do
    actual =
      Game.new()
      |> Game.mark(1, "X")
      |> Game.mark(1, "O")

    expected =
      Game.new()
      |> Game.mark(1, "X")

    assert actual == expected
  end

  test "mark invalid index raises" do
    assert_raise(RuntimeError, fn -> Game.new() |> Game.mark(10, "X") end)
  end

  test "identify ties" do
    assert %Game{
             board: %{
               1 => "X",
               2 => "O",
               3 => "O",
               4 => "O",
               5 => "X",
               6 => "X",
               7 => "O",
               8 => "X",
               9 => "O"
             }
           }
           |> Game.status() == :tie
  end

  test "incomplete game is in progress" do
    assert Game.new() |> Game.status() == :in_progress
  end

  test "x wins" do
    assert Game.new()
           |> Game.mark(1, "X")
           |> Game.mark(4, "O")
           |> Game.mark(2, "X")
           |> Game.mark(5, "O")
           |> Game.mark(3, "X")
           |> Game.status() == {:complete, "X"}
  end

  test "x can't go twice in a row" do
    game = Game.new() |> Game.mark(1, "X")
    assert game == Game.mark(game, 2, "X")
  end
end
