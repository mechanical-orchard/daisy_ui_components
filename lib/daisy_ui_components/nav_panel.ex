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
  attr :current_nav_name, :string, default: "Navigation", doc: "The name of the current navigation panel"
  attr :current_user, :map, default: nil, doc: "The current user, if logged in"
  attr :id, :string, required: true, doc: "The ID of the navigation panel"
  attr :logo_image, :string, default: nil, doc: "The logo image to display in the navigation panel"
  attr :nav_items, :list, required: true, doc: "A list of navigation items in the format `{name, url}`"

  def nav_panel(assigns) do
    ~H"""
    <.drawer class="h-56 lg:drawer z-10" selector_id={@id}>
      <:drawer_content class="flex flex-col items-center justify-center">
        <div class="flex flex-col grow relative overflow-hidden">
          <header class="px-4 border-b shadow-sm">
            <div class="min-h-20 flex items-center justify-between py-3 text-sm">
              <div class="flex items-center">
                <.nav_trigger aria-label="Toggle navigation menu" target={@id} class="cursor-pointer">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke-width="1.5"
                    stroke="currentColor"
                    class="size-6"
                  >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 9h16.5m-16.5 6.75h16.5" />
                  </svg>
                </.nav_trigger>

                <span class="ml-3 text-lg">
                  {@current_nav_name}
                </span>
              </div>

              <%= if @current_user do %>
                <div>
                  <span class="mr-4 text-base">Hello, {@current_user.name}</span>
                  <.link
                    role="button"
                    class="py-2.5 px-5 mb-2 text-sm text-base text-gray-900 focus:outline-hidden rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100"
                    href="/logout"
                  >
                    Logout
                  </.link>
                </div>
              <% end %>
            </div>
          </header>
        </div>
      </:drawer_content>
      <:drawer_side>
        <.menu class="bg-base-200 text-base-content min-h-full w-80 p-4">
          <:item
            :if={@logo_image}
            class="gap-x-3 p-2 hover:bg-background-inverse-primary hover:text-content-inverse-primary"
          >
            <div class="flex items-center justify-center">
              <.link navigate="/">
                <img src={@logo_image} class="w-full" />
              </.link>
            </div>
          </:item>
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
    <label for={@target} class="bg-base-200 text-content-base btn drawer-button lg" {@rest}>
      {render_slot(@inner_block)}
    </label>
    """
  end
end
