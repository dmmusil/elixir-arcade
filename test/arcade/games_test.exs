defmodule Arcade.GamesTest do
  use Arcade.DataCase

  alias Arcade.Games

  describe "tictactoe" do
    alias Arcade.Games.TicTacToe

    @valid_attrs %{state: %{}}
    @update_attrs %{state: %{}}
    @invalid_attrs %{state: nil}

    def tic_tac_toe_fixture(attrs \\ %{}) do
      {:ok, tic_tac_toe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_tic_tac_toe()

      tic_tac_toe
    end

    test "list_tictactoe/0 returns all tictactoe" do
      tic_tac_toe = tic_tac_toe_fixture()
      assert Games.list_tictactoe() == [tic_tac_toe]
    end

    test "get_tic_tac_toe!/1 returns the tic_tac_toe with given id" do
      tic_tac_toe = tic_tac_toe_fixture()
      assert Games.get_tic_tac_toe!(tic_tac_toe.id) == tic_tac_toe
    end

    test "create_tic_tac_toe/1 with valid data creates a tic_tac_toe" do
      assert {:ok, %TicTacToe{} = tic_tac_toe} = Games.create_tic_tac_toe(@valid_attrs)
      assert tic_tac_toe.state == %{}
    end

    test "create_tic_tac_toe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_tic_tac_toe(@invalid_attrs)
    end

    test "update_tic_tac_toe/2 with valid data updates the tic_tac_toe" do
      tic_tac_toe = tic_tac_toe_fixture()
      assert {:ok, %TicTacToe{} = tic_tac_toe} = Games.update_tic_tac_toe(tic_tac_toe, @update_attrs)
      assert tic_tac_toe.state == %{}
    end

    test "update_tic_tac_toe/2 with invalid data returns error changeset" do
      tic_tac_toe = tic_tac_toe_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_tic_tac_toe(tic_tac_toe, @invalid_attrs)
      assert tic_tac_toe == Games.get_tic_tac_toe!(tic_tac_toe.id)
    end

    test "delete_tic_tac_toe/1 deletes the tic_tac_toe" do
      tic_tac_toe = tic_tac_toe_fixture()
      assert {:ok, %TicTacToe{}} = Games.delete_tic_tac_toe(tic_tac_toe)
      assert_raise Ecto.NoResultsError, fn -> Games.get_tic_tac_toe!(tic_tac_toe.id) end
    end

    test "change_tic_tac_toe/1 returns a tic_tac_toe changeset" do
      tic_tac_toe = tic_tac_toe_fixture()
      assert %Ecto.Changeset{} = Games.change_tic_tac_toe(tic_tac_toe)
    end
  end
end
