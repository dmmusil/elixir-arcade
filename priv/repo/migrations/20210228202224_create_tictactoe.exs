defmodule Arcade.Repo.Migrations.CreateTictactoe do
  use Ecto.Migration

  def change do
    create table(:tictactoe) do
      add :board, :map
      add :status, :string
      add :player, :string

      timestamps()
    end

  end
end
