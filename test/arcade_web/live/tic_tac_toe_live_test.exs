defmodule ArcadeWeb.TicTacToeLiveTest do
  use ArcadeWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Arcade.Games

  @create_attrs %{state: %{}}
  @update_attrs %{state: %{}}
  @invalid_attrs %{state: nil}

  defp fixture(:tic_tac_toe) do
    {:ok, tic_tac_toe} = Games.create_tic_tac_toe(@create_attrs)
    tic_tac_toe
  end

  defp create_tic_tac_toe(_) do
    tic_tac_toe = fixture(:tic_tac_toe)
    %{tic_tac_toe: tic_tac_toe}
  end

  describe "Index" do
    setup [:create_tic_tac_toe]

    test "lists all tictactoe", %{conn: conn, tic_tac_toe: tic_tac_toe} do
      {:ok, _index_live, html} = live(conn, Routes.tic_tac_toe_index_path(conn, :index))

      assert html =~ "Listing Tictactoe"
    end

    test "saves new tic_tac_toe", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.tic_tac_toe_index_path(conn, :index))

      assert index_live |> element("a", "New Tic tac toe") |> render_click() =~
               "New Tic tac toe"

      assert_patch(index_live, Routes.tic_tac_toe_index_path(conn, :new))

      assert index_live
             |> form("#tic_tac_toe-form", tic_tac_toe: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tic_tac_toe-form", tic_tac_toe: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tic_tac_toe_index_path(conn, :index))

      assert html =~ "Tic tac toe created successfully"
    end

    test "updates tic_tac_toe in listing", %{conn: conn, tic_tac_toe: tic_tac_toe} do
      {:ok, index_live, _html} = live(conn, Routes.tic_tac_toe_index_path(conn, :index))

      assert index_live |> element("#tic_tac_toe-#{tic_tac_toe.id} a", "Edit") |> render_click() =~
               "Edit Tic tac toe"

      assert_patch(index_live, Routes.tic_tac_toe_index_path(conn, :edit, tic_tac_toe))

      assert index_live
             |> form("#tic_tac_toe-form", tic_tac_toe: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tic_tac_toe-form", tic_tac_toe: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tic_tac_toe_index_path(conn, :index))

      assert html =~ "Tic tac toe updated successfully"
    end

    test "deletes tic_tac_toe in listing", %{conn: conn, tic_tac_toe: tic_tac_toe} do
      {:ok, index_live, _html} = live(conn, Routes.tic_tac_toe_index_path(conn, :index))

      assert index_live |> element("#tic_tac_toe-#{tic_tac_toe.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tic_tac_toe-#{tic_tac_toe.id}")
    end
  end

  describe "Show" do
    setup [:create_tic_tac_toe]

    test "displays tic_tac_toe", %{conn: conn, tic_tac_toe: tic_tac_toe} do
      {:ok, _show_live, html} = live(conn, Routes.tic_tac_toe_show_path(conn, :show, tic_tac_toe))

      assert html =~ "Show Tic tac toe"
    end

    test "updates tic_tac_toe within modal", %{conn: conn, tic_tac_toe: tic_tac_toe} do
      {:ok, show_live, _html} = live(conn, Routes.tic_tac_toe_show_path(conn, :show, tic_tac_toe))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tic tac toe"

      assert_patch(show_live, Routes.tic_tac_toe_show_path(conn, :edit, tic_tac_toe))

      assert show_live
             |> form("#tic_tac_toe-form", tic_tac_toe: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#tic_tac_toe-form", tic_tac_toe: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tic_tac_toe_show_path(conn, :show, tic_tac_toe))

      assert html =~ "Tic tac toe updated successfully"
    end
  end
end
