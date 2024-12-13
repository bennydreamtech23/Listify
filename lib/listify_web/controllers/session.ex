defmodule ListifyWeb.Session do
  use ListifyWeb, :controller

  def set_user_name(conn, %{"user_name" => user_name}) do
    conn
    |> put_session(:user_name, user_name)
    |> redirect(to: ~p"/list")
  end
end
