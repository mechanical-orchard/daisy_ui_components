defmodule DaisyUIComponents.NavPanel do
  use DaisyUIComponents, :component
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
  attr :nav_items, :list, required: true, doc: "A list of navigation items in the format `{name, url}` or `{section_name, items}` for grouped items"

  def nav_panel(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "py-6 px-8 flex flex-col min-h-full border-r border-base-300 w-64 min-w-64 justify-start bg-base-100",
        "transition-all duration-300 ease-in-out"
      ]}
      phx-update="ignore"
    >
      <div :if={@logo_image} class="mb-8">
        <.link navigate="/" class="block">
          <img src={@logo_image} class="w-full" />
        </.link>
      </div>
      
      <nav class="flex flex-1 flex-col space-y-1 text-nowrap">
        <%= for {item, index} <- Enum.with_index(@nav_items) do %>
          <%= if is_tuple(item) and tuple_size(item) == 2 do %>
            <% {section_name, section_items} = item %>
            <%= if is_list(section_items) do %>
              <div class={["nav-section", index > 0 && "mt-6"]}>
                <div class="px-2 pt-1 pb-4 text-md font-semibold text-base-content/60 tracking-wider">
                  {section_name}
                </div>
                <div class="space-y-1">
                  <%= for {sub_name, sub_url} <- section_items do %>
                    <.link 
                      navigate={sub_url}
                      class={"group flex gap-x-3 rounded-md p-2 m--2 text-lg font-medium transition-colors #{if URI.parse(@current_url).path == sub_url, do: "bg-primary text-primary-content shadow-sm", else: "text-base-content/70 hover:bg-base-200 hover:text-base-content"}"}
                    >
                      {sub_name}
                    </.link>
                  <% end %>
                </div>
              </div>
            <% else %>
              <% {name, url} = item %>
              <.link 
                navigate={url}
                class={"group flex gap-x-3 rounded-md p-2 text-lg font-medium transition-colors #{if URI.parse(@current_url).path == url, do: "bg-primary text-primary-content shadow-sm", else: "text-base-content/70 hover:bg-base-200 hover:text-base-content"}"}
              >
                {name}
              </.link>
            <% end %>
          <% else %>
            <% {name, url} = item %>
            <.link 
              navigate={url}
              class={"group flex gap-x-3 rounded-md p-2 text-lg font-medium transition-colors #{if URI.parse(@current_url).path == url, do: "bg-primary text-primary-content shadow-sm", else: "text-base-content/70 hover:bg-base-200 hover:text-base-content"}"}
            >
              {name}
            </.link>
          <% end %>
        <% end %>
      </nav>
    </div>
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
