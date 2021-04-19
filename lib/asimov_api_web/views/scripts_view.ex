defmodule AsimovApiWeb.ScriptsView do
  use AsimovApiWeb, :view

  def render("create.json", %{script: %{}}) do
    %{
      message: "Script created!"
    }
  end
end
