defmodule KatanaWeb.ErrorJSONTest do
  use KatanaWeb.ConnCase, async: true

  test "renders 404" do
    assert KatanaWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert KatanaWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
