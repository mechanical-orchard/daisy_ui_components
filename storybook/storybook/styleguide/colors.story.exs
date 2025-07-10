defmodule Storybook.Components.Colors do
  use PhoenixStorybook.Story, :example

  @colors [
    %{
      name: "primary",
      class: "bg-primary",
      description: "Primary brand color, The main color of your brand",
      light_oklch: "oklch(49.12% 0.3096 275.75)",
      dark_oklch: "oklch(49.12% 0.3096 275.75)"
    },
    %{
      name: "primary-content",
      class: "bg-primary-content",
      description: "Foreground content color to use on primary color",
      light_oklch: "oklch(98.71% 0.0106 275.75)",
      dark_oklch: "oklch(98.71% 0.0106 275.75)"
    },
    %{
      name: "secondary",
      class: "bg-secondary",
      description: "Secondary brand color, The optional, secondary color of your brand",
      light_oklch: "oklch(60.32% 0.191 183.61)",
      dark_oklch: "oklch(60.32% 0.191 183.61)"
    },
    %{
      name: "secondary-content",
      class: "bg-secondary-content",
      description: "Foreground content color to use on secondary color",
      light_oklch: "oklch(98.71% 0.0106 183.61)",
      dark_oklch: "oklch(98.71% 0.0106 183.61)"
    },
    %{
      name: "accent",
      class: "bg-accent",
      description: "Accent brand color, The optional, accent color of your brand",
      light_oklch: "oklch(64.32% 0.229 183.61)",
      dark_oklch: "oklch(64.32% 0.229 183.61)"
    },
    %{
      name: "accent-content",
      class: "bg-accent-content",
      description: "Foreground content color to use on accent color",
      light_oklch: "oklch(98.71% 0.0106 183.61)",
      dark_oklch: "oklch(98.71% 0.0106 183.61)"
    },
    %{
      name: "neutral",
      class: "bg-neutral",
      description: "Neutral dark color, For not-saturated parts of UI",
      light_oklch: "oklch(25.08% 0 0)",
      dark_oklch: "oklch(25.08% 0 0)"
    },
    %{
      name: "neutral-content",
      class: "bg-neutral-content",
      description: "Foreground content color to use on neutral color",
      light_oklch: "oklch(98.71% 0.0106 0)",
      dark_oklch: "oklch(98.71% 0.0106 0)"
    },
    %{
      name: "base-100",
      class: "bg-base-100",
      description: "Base surface color of page, used for blank backgrounds",
      light_oklch: "oklch(100% 0 0)",
      dark_oklch: "oklch(0% 0 0)"
    },
    %{
      name: "base-200",
      class: "bg-base-200",
      description: "Base color, darker shade, to create elevations",
      light_oklch: "oklch(96.05% 0.0059 0)",
      dark_oklch: "oklch(13.63% 0.0059 0)"
    },
    %{
      name: "base-300",
      class: "bg-base-300",
      description: "Base color, even more darker shade, to create elevations",
      light_oklch: "oklch(91.49% 0.0118 0)",
      dark_oklch: "oklch(27.25% 0.0118 0)"
    },
    %{
      name: "base-content",
      class: "bg-base-content",
      description: "Foreground content color to use on base color",
      light_oklch: "oklch(25.08% 0 0)",
      dark_oklch: "oklch(98.71% 0.0106 0)"
    },
    %{
      name: "info",
      class: "bg-info",
      description: "Info color, For informative/helpful messages",
      light_oklch: "oklch(79.12% 0.1573 229.18)",
      dark_oklch: "oklch(79.12% 0.1573 229.18)"
    },
    %{
      name: "info-content",
      class: "bg-info-content",
      description: "Foreground content color to use on info color",
      light_oklch: "oklch(98.71% 0.0106 229.18)",
      dark_oklch: "oklch(98.71% 0.0106 229.18)"
    },
    %{
      name: "success",
      class: "bg-success",
      description: "Success color, For success/safe messages",
      light_oklch: "oklch(71.32% 0.1968 142.5)",
      dark_oklch: "oklch(71.32% 0.1968 142.5)"
    },
    %{
      name: "success-content",
      class: "bg-success-content",
      description: "Foreground content color to use on success color",
      light_oklch: "oklch(98.71% 0.0106 142.5)",
      dark_oklch: "oklch(98.71% 0.0106 142.5)"
    },
    %{
      name: "warning",
      class: "bg-warning",
      description: "Warning color, For warning/caution messages",
      light_oklch: "oklch(85.49% 0.1871 85.87)",
      dark_oklch: "oklch(85.49% 0.1871 85.87)"
    },
    %{
      name: "warning-content",
      class: "bg-warning-content",
      description: "Foreground content color to use on warning color",
      light_oklch: "oklch(25.08% 0 85.87)",
      dark_oklch: "oklch(25.08% 0 85.87)"
    },
    %{
      name: "error",
      class: "bg-error",
      description: "Error color, For error/danger/destructive messages",
      light_oklch: "oklch(63.32% 0.2406 29.23)",
      dark_oklch: "oklch(63.32% 0.2406 29.23)"
    },
    %{
      name: "error-content",
      class: "bg-error-content",
      description: "Foreground content color to use on error color",
      light_oklch: "oklch(98.71% 0.0106 29.23)",
      dark_oklch: "oklch(98.71% 0.0106 29.23)"
    }
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
              <th class="text-left">Light OKLCH</th>
              <th class="text-left">Dark OKLCH</th>
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
                <td class="font-mono text-xs">{color.light_oklch}</td>
                <td class="font-mono text-xs">{color.dark_oklch}</td>
                <td class="text-xs text-base-content/70">{color.description}</td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
