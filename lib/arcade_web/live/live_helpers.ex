defmodule ArcadeWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `ArcadeWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, ArcadeWeb.TicTacToeLive.FormComponent,
        id: @tic_tac_toe.id || :new,
        action: @live_action,
        tic_tac_toe: @tic_tac_toe,
        return_to: Routes.tic_tac_toe_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, ArcadeWeb.ModalComponent, modal_opts)
  end
end
