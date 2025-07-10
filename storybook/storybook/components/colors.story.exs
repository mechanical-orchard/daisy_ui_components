defmodule Storybook.Components.Colors do
  use PhoenixStorybook.Story, :example

  @colors [
    %{name: "primary", class: "bg-primary", description: "Primary brand color, The main color of your brand"},
    %{
      name: "primary-content",
      class: "bg-primary-content",
      description: "Foreground content color to use on primary color"
    },
    %{
      name: "secondary",
      class: "bg-secondary",
      description: "Secondary brand color, The optional, secondary color of your brand"
    },
    %{
      name: "secondary-content",
      class: "bg-secondary-content",
      description: "Foreground content color to use on secondary color"
    },
    %{name: "accent", class: "bg-accent", description: "Accent brand color, The optional, accent color of your brand"},
    %{
      name: "accent-content",
      class: "bg-accent-content",
      description: "Foreground content color to use on accent color"
    },
    %{name: "neutral", class: "bg-neutral", description: "Neutral dark color, For not-saturated parts of UI"},
    %{
      name: "neutral-content",
      class: "bg-neutral-content",
      description: "Foreground content color to use on neutral color"
    },
    %{name: "base-100", class: "bg-base-100", description: "Base surface color of page, used for blank backgrounds"},
    %{name: "base-200", class: "bg-base-200", description: "Base color, darker shade, to create elevations"},
    %{name: "base-300", class: "bg-base-300", description: "Base color, even more darker shade, to create elevations"},
    %{name: "base-content", class: "bg-base-content", description: "Foreground content color to use on base color"},
    %{name: "info", class: "bg-info", description: "Info color, For informative/helpful messages"},
    %{name: "info-content", class: "bg-info-content", description: "Foreground content color to use on info color"},
    %{name: "success", class: "bg-success", description: "Success color, For success/safe messages"},
    %{
      name: "success-content",
      class: "bg-success-content",
      description: "Foreground content color to use on success color"
    },
    %{name: "warning", class: "bg-warning", description: "Warning color, For warning/caution messages"},
    %{
      name: "warning-content",
      class: "bg-warning-content",
      description: "Foreground content color to use on warning color"
    },
    %{name: "error", class: "bg-error", description: "Error color, For error/danger/destructive messages"},
    %{name: "error-content", class: "bg-error-content", description: "Foreground content color to use on error color"}
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, colors: @colors)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-7xl mx-auto space-y-8">
      <div class="text-center">
        <h1 class="text-4xl font-bold mb-4">DaisyUI Colors</h1>
        <p class="text-lg text-base-content/70">
          Standard DaisyUI color palette with light and dark mode variants side by side.<br />
          <a
            href="https://daisyui.com/docs/colors/#list-of-all-daisyui-color-names"
            class="link link-primary"
            target="_blank"
          >
            Reference: daisyUI color docs
          </a>
        </p>
      </div>

      <div class="overflow-x-auto">
        <table class="table w-full">
          <thead>
            <tr>
              <th class="text-center" data-theme="light">Light</th>
              <th class="text-center" data-theme="dark">Dark</th>
              <th class="text-left">Color name</th>
              <th class="text-left">CSS variable</th>
              <th class="text-left">Where to use</th>
            </tr>
          </thead>
          <tbody>
            <%= for color <- @colors do %>
              <tr>
                <td class="text-center" data-theme="light">
                  <div class={"w-16 h-12 rounded-lg " <> color.class <> " border border-base-300 mx-auto"}></div>
                </td>
                <td class="text-center" data-theme="dark">
                  <div class={"w-16 h-12 rounded-lg " <> color.class <> " border border-base-300 mx-auto"}></div>
                </td>
                <td class="font-mono text-sm">{color.name}</td>
                <td class="font-mono text-xs">{color.class}</td>
                <td class="text-xs text-base-content/70">{color.description}</td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
      
    <!-- Description Section -->
      <div class="space-y-4">
        <h3 class="text-xl font-semibold">Color Descriptions</h3>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <%= for color <- @colors do %>
            <div class="card bg-base-100 shadow-sm border border-base-300">
              <div class="card-body p-4">
                <h4 class="card-title text-sm font-mono">{color.class}</h4>
                <p class="text-xs text-base-content/70">{color.description}</p>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
