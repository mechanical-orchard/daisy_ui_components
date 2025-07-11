defmodule DaisyUIComponents.ApplicationLayout do
  @moduledoc """
  Application layout component

  """

  use DaisyUIComponents, :component
  import DaisyUIComponents.Alert
  import DaisyUIComponents.Header
  import DaisyUIComponents.Icon
  import DaisyUIComponents.NavPanel
  import DaisyUIComponents.ThemeToggle

  @doc """
  Renders the app layout

  ## Examples

      <.app flash={@flash}>
        <h1>Content</h1>
      </.app>

      With grouped navigation:

      <.app 
        flash={@flash}
        nav_items={[
          {"Vision", [
            {"System View", "/system"},
            {"Dashboard", "/dashboard"}
          ]},
          {"Progress", "/progress"},
          {"Replication", "/replication"}
        ]}
      >
        <h1>Content</h1>
      </.app>

  """
  attr :class, :any, default: nil

  attr :current_nav_name, :string,
    default: "Navigation",
    doc: "the name of the current navigation panel, used for accessibility"

  attr :breadcrumbs, :list,
    default: [],
    doc: "list of breadcrumb items in the format `{name, url}` or just `name` for current page"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  attr :current_url, :string,
    default: nil,
    doc: "the current URL, used to highlight the active navigation item"

  attr :current_user, :map,
    default: nil,
    doc: "the current user, if logged in, used to display user-specific information"

  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :logo_image, :string, default: nil, doc: "The logo image to display in the navigation panel"
  attr :nav_items, :list, required: true, doc: "A list of navigation items in the format `{name, url}`"
  attr :nav_panel_id, :string, default: nil, doc: "The ID of the navigation panel"
  attr :show_theme_toggle, :boolean, default: false, doc: "Whether to show the theme toggle button"

  slot :inner_block, required: true

  def app(assigns) do
    assigns =
      assigns
      |> assign_new(:nav_panel_id, fn -> "nav-panel" end)
      |> assign(
        :class,
        classes([
          "flex relative overflow-hidden",
          assigns.class
        ])
      )

    ~H"""
    <div class={@class}>
      <.flash_group flash={@flash} />

      <.nav_panel id={@nav_panel_id} current_url={@current_url} nav_items={@nav_items} logo_image={@logo_image} />
      <div class="flex flex-col grow relative overflow-hidden">
        <div class="px-4 border-b border-base-300 shadow-sm z-10">
          <.header class="min-h-20 flex items-center justify-between py-3 text-sm text-base-content">
            <div class="flex items-center">
              <.nav_trigger
                aria-label="Toggle navigation menu"
                target={@nav_panel_id}
                class="bg-base-200 text-base-content cursor-pointer rounded-lg p-2 hover:bg-base-300"
              >
                <.sidebar_icon />
              </.nav_trigger>

              <div class="ml-3 flex items-center text-base-content">
                <nav class="flex items-center space-x-2 text-sm">
                  <%= for {item, index} <- Enum.with_index(get_breadcrumbs(@nav_items, @current_url, @breadcrumbs)) do %>
                    <%= if index > 0 do %>
                      <.icon name="hero-chevron-right" class="w-4 h-4 text-base-content/50" />
                    <% end %>
                    
                    <%= if is_tuple(item) do %>
                      <% {name, url} = item %>
                      <.link navigate={url} class="text-base-content/70 hover:text-base-content">
                        {name}
                      </.link>
                    <% else %>
                      <span class="text-base-content font-medium">{item}</span>
                    <% end %>
                  <% end %>
                </nav>
              </div>
            </div>
            <:actions>
              <%= if @current_user do %>
                <div class="flex items-center gap-4 text-sm text-base-content">
                  <div :if={@show_theme_toggle}>
                    <.theme_toggle />
                  </div>
                  <span class="text-base text-base-content">Hello, {@current_user.name}</span>
                  <.link
                    role="button"
                    class="py-2.5 px-5 text-sm text-base-content focus:outline-hidden rounded-lg border border-base-300 hover:bg-background-inverse-primary hover:text-content-inverse-primary focus:z-10 focus:ring-4 focus:ring-base-200"
                    href="/logout"
                  >
                    Logout
                  </.link>
                </div>
              <% end %>
            </:actions>
          </.header>
        </div>
        <main class="bg-background-secondary h-[calc(100vh-64px)] w-full overflow-hidden">
          <div class="h-full w-full flex flex-col">
            <div class="flex flex-col px-4 py-4 h-full">
              {render_slot(@inner_block)}
            </div>
          </div>
        </main>
      </div>
    </div>
    """
  end

  defp sidebar_icon(assigns) do
    ~H"""
    <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M15.1875 3.75C15.1875 3.23223 14.7678 2.8125 14.25 2.8125H3.75C3.23223 2.8125 2.8125 3.23223 2.8125 3.75V14.25C2.8125 14.7678 3.23223 15.1875 3.75 15.1875H14.25C14.7678 15.1875 15.1875 14.7678 15.1875 14.25V3.75ZM16.3125 14.25C16.3125 15.3891 15.3891 16.3125 14.25 16.3125H3.75C2.61091 16.3125 1.6875 15.3891 1.6875 14.25V3.75C1.6875 2.61091 2.61091 1.6875 3.75 1.6875H14.25C15.3891 1.6875 16.3125 2.61091 16.3125 3.75V14.25Z" fill="#09090B"/>
      <path d="M6.1875 15.75V2.25C6.1875 1.93934 6.43934 1.6875 6.75 1.6875C7.06066 1.6875 7.3125 1.93934 7.3125 2.25V15.75C7.3125 16.0607 7.06066 16.3125 6.75 16.3125C6.43934 16.3125 6.1875 16.0607 6.1875 15.75Z" fill="#09090B"/>
    </svg>
    """
  end

  # Helper function to build breadcrumbs from nav data
  defp get_breadcrumbs(nav_items, current_url, extra_breadcrumbs \\ []) do
    nav_breadcrumbs = find_breadcrumbs(nav_items, current_url)
    nav_breadcrumbs ++ extra_breadcrumbs
  end

  # Find breadcrumbs by traversing nav structure
  defp find_breadcrumbs(nav_items, current_url) do
    current_path = URI.parse(current_url).path
    
    nav_items
    |> Enum.reduce_while([], fn item, acc ->
      case item do
        {section_name, section_items} when is_list(section_items) ->
          # Check if current URL is in this section
          case find_in_section(section_items, current_path) do
            nil -> {:cont, acc}
            {item_name, _url} -> {:halt, [{section_name, nil}, item_name]}
          end
        
        {name, url} ->
          if URI.parse(url).path == current_path do
            {:halt, [name]}
          else
            {:cont, acc}
          end
      end
    end)
  end

  # Find item in section
  defp find_in_section(section_items, current_path) do
    Enum.find(section_items, fn {_name, url} ->
      URI.parse(url).path == current_path
    end)
  end
end
