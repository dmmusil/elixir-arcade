defmodule Arcade.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Arcade.Repo

  alias Arcade.Games.TicTacToe

  @doc """
  Returns the list of tictactoe.

  ## Examples

      iex> list_tictactoe()
      [%TicTacToe{}, ...]

  """
  def list_tictactoe do
    Repo.all(TicTacToe)
  end

  @doc """
  Gets a single tic_tac_toe.

  Raises `Ecto.NoResultsError` if the Tic tac toe does not exist.

  ## Examples

      iex> get_tic_tac_toe!(123)
      %TicTacToe{}

      iex> get_tic_tac_toe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tic_tac_toe!(id), do: Repo.get!(TicTacToe, id)

  @doc """
  Creates a tic_tac_toe.

  ## Examples

      iex> create_tic_tac_toe(%{field: value})
      {:ok, %TicTacToe{}}

      iex> create_tic_tac_toe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tic_tac_toe() do
    TicTacToe.new()
    |> Repo.insert()
  end

  @doc """
  Updates a tic_tac_toe.

  ## Examples

      iex> update_tic_tac_toe(tic_tac_toe, %{field: new_value})
      {:ok, %TicTacToe{}}

      iex> update_tic_tac_toe(tic_tac_toe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tic_tac_toe(%TicTacToe{} = tic_tac_toe) do
    TicTacToe
    |> where(id: ^tic_tac_toe.id)
    |> Repo.update_all(
      set: [
        board: tic_tac_toe.board,
        player: tic_tac_toe.player,
        status:
          case Arcade.Games.TicTacToe.status(tic_tac_toe) do
            :in_progress -> "in_progress"
            _ -> "complete"
          end
      ]
    )
  end

  @doc """
  Deletes a tic_tac_toe.

  ## Examples

      iex> delete_tic_tac_toe(tic_tac_toe)
      {:ok, %TicTacToe{}}

      iex> delete_tic_tac_toe(tic_tac_toe)
      {:error, %Ecto.Changeset{}}

  """

  def delete_tic_tac_toe(%TicTacToe{} = tic_tac_toe) do
    Repo.delete(tic_tac_toe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tic_tac_toe changes.

  ## Examples

      iex> change_tic_tac_toe(tic_tac_toe)
      %Ecto.Changeset{data: %TicTacToe{}}

  """
  def change_tic_tac_toe(%TicTacToe{} = tic_tac_toe, attrs \\ %{}) do
    TicTacToe.changeset(tic_tac_toe, attrs)
  end
end
