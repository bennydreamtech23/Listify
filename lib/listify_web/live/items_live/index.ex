defmodule ListifyWeb.ItemsLive.Index do
  use ListifyWeb, :live_view


  @impl true
  def mount(_params, _session, socket) do


    socket =
      socket

      |>assign(:tab, true)



    {:ok, socket}
  end

end
