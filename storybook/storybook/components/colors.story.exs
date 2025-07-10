defmodule Storybook.Components.Colors do
  use PhoenixStorybook.Story, :example

  @doc """
  Shows all DaisyUI standard colors in a table, with light and dark mode variants side by side for easy comparison.
  """
  def render(assigns) do
    colors = [
      {"primary", "--color-primary", "Primary brand color, The main color of your brand"},
      {"secondary", "--color-secondary", "Secondary brand color, The optional, secondary color of your brand"},
      {"accent", "--color-accent", "Accent brand color, The optional, accent color of your brand"},
      {"neutral", "--color-neutral", "Neutral dark color, For not-saturated parts of UI"},
      {"base-100", "--color-base-100", "Base surface color of page, used for blank backgrounds"},
      {"base-200", "--color-base-200", "Base color, darker shade, to create elevations"},
      {"base-300", "--color-base-300", "Base color, even more darker shade, to create elevations"},
      {"info", "--color-info", "Info color, For informative/helpful messages"},
      {"success", "--color-success", "Success color, For success/safe messages"},
      {"warning", "--color-warning", "Warning color, For warning/caution messages"},
      {"error", "--color-error", "Error color, For error/danger/destructive messages"}
    ]

    content_colors = %{
      "primary" => "primary-content",
      "secondary" => "secondary-content",
      "accent" => "accent-content",
      "neutral" => "neutral-content",
      "base-100" => "base-content",
      "base-200" => "base-content",
      "base-300" => "base-content",
      "info" => "info-content",
      "success" => "success-content",
      "warning" => "warning-content",
      "error" => "error-content"
    }

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
                  <div class={"w-16 h-12 rounded bg-" <> name <> " flex items-center justify-center border border-base-300 mx-auto relative"}>
                    <span class={"text-xs font-bold text-" <> content_colors[name] <> " mix-blend-difference"}>
                      {name}
                    </span>
                    <!-- Fallback text for visibility -->
                    <span class="absolute inset-0 flex items-center justify-center text-xs font-bold text-black mix-blend-difference opacity-30">
                      {name}
                    </span>
                  </div>
                </td>
                <td class="text-center" data-theme="dark">
                  <div class={"w-16 h-12 rounded bg-" <> name <> " flex items-center justify-center border border-base-300 mx-auto relative"}>
                    <span class={"text-xs font-bold text-" <> content_colors[name] <> " mix-blend-difference"}>
                      {name}
                    </span>
                    <!-- Fallback text for visibility -->
                    <span class="absolute inset-0 flex items-center justify-center text-xs font-bold text-white mix-blend-difference opacity-30">
                      {name}
                    </span>
                  </div>
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
