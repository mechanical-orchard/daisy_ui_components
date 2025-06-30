defmodule DaisyUIComponents.NavPanel do
  use DaisyUIComponents, :component
  import DaisyUIComponents.Drawer
  import DaisyUIComponents.Menu

  @doc """
  Renders the navigation panel component. `current_url` is used to highlight the current nav item.

  ## Examples

      <.nav_panel nav_items={[{"Home", "/home"}, {"About", "/about"}]} current_url="/home">
      </.nav_panel>
      ...
      <.nav_trigger>
        <button>Toggle Nav</button>
      </.nav_trigger>
  """
  attr :current_url, :string, required: true, doc: "The current URL"
  attr :id, :string, required: true, doc: "The ID of the navigation panel"
  attr :logo_image, :string, default: nil, doc: "The logo image to display in the navigation panel"
  attr :nav_items, :list, required: true, doc: "A list of navigation items in the format `{name, url}`"

  def nav_panel(assigns) do
    ~H"""
    <.drawer class="h-56 lg:drawer-open" selector_id={@id}>
      <:drawer_content class="flex flex-col items-center justify-center">
        <label for="my-drawer-2" class="btn btn-primary drawer-button lg:hidden">
          Open drawer
        </label>
      </:drawer_content>
      <:drawer_side class="h-full absolute">
        <.link :if={@logo_image} navigate="/">
          <img src={@logo_image} class="-ml-6 -mt-6" />
        </.link>
        <.menu class="bg-base-200 text-base-content w-80 p-4">
          <:item
            :for={{name, url} <- @nav_items}
            class={"#{if URI.parse(@current_url).path == url, do: "bg-background-inverse-primary text-content-inverse-primary"} group flex gap-x-3 rounded-md p-2 text-lg hover:bg-background-inverse-primary hover:text-content-inverse-primary"}
          >
            <.link navigate={url}>
              {name}
            </.link>
          </:item>
        </.menu>
      </:drawer_side>
    </.drawer>
    """
  end

  @doc """
  Renders a trigger element to toggle the navigation panel.

  ## Examples

      <.nav_trigger target="nav-panel">
        <button>Toggle Nav</button>
      </.nav_trigger>
  """
  attr(:target, :string, required: true, doc: "The ID of the navigation panel to toggle")
  slot(:inner_block, required: true, doc: "The trigger element to render")
  attr(:rest, :global, doc: "The remaining attributes to pass through to the trigger element")

  def nav_trigger(assigns) do
    ~H"""
    <div phx-click={toggle_nav("#" <> @target)} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp toggle_nav(id) do
    %JS{}
    |> JS.toggle_class(
      "w-0! min-w-0! p-0! opacity-0 invisible",
      to: "#{id}",
      time: 300
    )
  end
end
