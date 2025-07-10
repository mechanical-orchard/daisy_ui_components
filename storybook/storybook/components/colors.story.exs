defmodule Storybook.Components.Colors do
  use PhoenixStorybook.Story, :example

  @doc """
  Shows all DaisyUI standard colors in a table, with light and dark mode variants side by side for easy comparison.
  """
  def render(assigns) do
    colors = [
      {"primary", "--color-primary", "Primary brand color, The main color of your brand"},
      {"primary-content", "--color-primary-content", "Foreground content color to use on primary color"},
      {"secondary", "--color-secondary", "Secondary brand color, The optional, secondary color of your brand"},
      {"secondary-content", "--color-secondary-content", "Foreground content color to use on secondary color"},
      {"accent", "--color-accent", "Accent brand color, The optional, accent color of your brand"},
      {"accent-content", "--color-accent-content", "Foreground content color to use on accent color"},
      {"neutral", "--color-neutral", "Neutral dark color, For not-saturated parts of UI"},
      {"neutral-content", "--color-neutral-content", "Foreground content color to use on neutral color"},
      {"base-100", "--color-base-100", "Base surface color of page, used for blank backgrounds"},
      {"base-200", "--color-base-200", "Base color, darker shade, to create elevations"},
      {"base-300", "--color-base-300", "Base color, even more darker shade, to create elevations"},
      {"base-content", "--color-base-content", "Foreground content color to use on base color"},
      {"info", "--color-info", "Info color, For informative/helpful messages"},
      {"info-content", "--color-info-content", "Foreground content color to use on info color"},
      {"success", "--color-success", "Success color, For success/safe messages"},
      {"success-content", "--color-success-content", "Foreground content color to use on success color"},
      {"warning", "--color-warning", "Warning color, For warning/caution messages"},
      {"warning-content", "--color-warning-content", "Foreground content color to use on warning color"},
      {"error", "--color-error", "Error color, For error/danger/destructive messages"},
      {"error-content", "--color-error-content", "Foreground content color to use on error color"}
    ]

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
              <th class="text-center">Light</th>
              <th class="text-center" data-theme="dark">Dark</th>
              <th class="text-left">Color name</th>
              <th class="text-left">CSS variable</th>
              <th class="text-left">Where to use</th>
            </tr>
          </thead>
          <tbody>
            <%= for {name, var, desc} <- colors do %>
              <tr>
                <td class="text-center">
                  <div class={"w-16 h-12 rounded-lg bg-" <> name <> " border border-base-300 mx-auto"}></div>
                </td>
                <td class="text-center" data-theme="dark">
                  <div class={"w-16 h-12 rounded-lg bg-" <> name <> " border border-base-300 mx-auto"}></div>
                </td>
                <td class="font-mono text-sm">{name}</td>
                <td class="font-mono text-xs">{var}</td>
                <td class="text-xs text-base-content/70">{desc}</td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
      
    <!-- Description Section -->
      <div class="space-y-4">
        <h3 class="text-xl font-semibold">Color Descriptions</h3>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <%= for {name, var, desc} <- colors do %>
            <div class="card bg-base-100 shadow-sm border border-base-300">
              <div class="card-body p-4">
                <h4 class="card-title text-sm font-mono">bg-{name}</h4>
                <p class="text-xs text-base-content/70">{desc}</p>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
