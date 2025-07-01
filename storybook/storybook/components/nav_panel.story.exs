defmodule Storybook.Components.NavPanel do
  use PhoenixStorybook.Story, :component
  alias DaisyUIComponents.NavPanel
  alias DaisyUIComponents.Drawer
  alias DaisyUIComponents.Menu

  def function, do: &NavPanel.nav_panel/1

  def imports,
    do: [{Drawer, drawer: 1}, {Menu, menu: 1}]

  def variations do
    [
      %Variation{
        id: :nav_panel,
        attributes: %{
          class: "bg-base-200 shadow-xl rounded-box",
          id: "nav-panel",
          current_url: "/some-url",
          current_nav_name: "System View",
          current_user: %{
            name: "John Doe",
            email: "unknown@email.edu"
          },
          nav_items: [
            {"Navigation Item 1", "/some-url"},
            {"Navigation Item 2", "/another-url"}
          ]
        }
      },
      %Variation{
        id: :nav_panel_with_logo,
        attributes: %{
          class: "bg-base-200 shadow-xl rounded-box",
          id: "nav-panel-with-logo",
          current_url: "/some-url",
          current_nav_name: "System View",
          current_user: %{
            name: "John Doe",
            email: "unknown@email.edu"
          },
          logo_image: "/images/logo.svg",
          nav_items: [
            {"Navigation Item 1", "/some-url"},
            {"Navigation Item 2", "/another-url"}
          ]
        }
      }
    ]
  end
end
