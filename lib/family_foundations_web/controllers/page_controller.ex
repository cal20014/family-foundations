defmodule FamilyFoundationsWeb.PageController do
  use FamilyFoundationsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
