defmodule ListifyWeb.ItemsLive.Index do
  use ListifyWeb, :live_view

  alias Listify.Grocerys
  alias Listify.Grocerys.Grocery
  alias Listify.Categorys
  alias Listify.Users

  @impl true
  def mount(_params, session, socket) do
    user_name = session["user_name"]
    IO.inspect(user_name, label: "user name")
    categories = Categorys.list_categories()
    changeset = Grocerys.change_grocery(%Grocery{})

    category_options =
      Enum.map(categories, fn category ->
        {category.name, category.id}
      end)

    name = Users.get_user_by_user_name!(user_name)

    user_id = name.id

    groceries_list = Grocerys.list_groceries(user_id)

    category_ids = Enum.map(groceries_list, & &1.category_id)



    categories = Categorys.get_all_category(category_ids)

    category_map = Map.new(categories, &{&1.id, &1.name})


    groceries_with_category_names =
    Enum.map(groceries_list, fn grocery ->
      Map.put(grocery, :category_name, category_map[grocery.category_id])
    end)


    socket =
      socket
      |> assign_form(changeset)
      |> assign(:user_id, user_id)
      |> assign(:tab, false)
      |> assign(:groceries_list, groceries_with_category_names)
      |> assign(:categories, category_options)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate_item", %{"grocery" => grocery}, socket) do
    # Update the grocery map with user_id and category_id
    grocery =
      grocery
      |> Map.put("user_id", socket.assigns.user_id)

    # Generate the changeset
    changeset = Grocerys.change_grocery(%Grocery{}, grocery)

    # Assign the changeset back to the socket
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  def handle_event("submit_item", %{"grocery" => grocery}, socket) do
    grocery =
      grocery
      |> Map.put("user_id", socket.assigns.user_id)

    changeset = Grocerys.change_grocery(%Grocery{}, grocery)

    if changeset.valid? do
      case Grocerys.create_grocery(grocery) do
        {:ok, grocery} ->
          # Clear the form by assigning a fresh changeset
          new_changeset = Grocerys.change_grocery(%Grocery{})

          socket =
            socket
            |> put_flash(:info, "Grocery #{grocery.name} Added!")
            |> assign(:form, to_form(new_changeset))

          {:noreply, socket}

        {:error, _reason} ->
          {:noreply, socket}
      end
    else
      {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
    end
  end

  @impl true
  def handle_event("add_grocery", _params, socket) do
    # Toggle the :tab assign
    new_tab_state = not socket.assigns[:tab]

    socket =
      socket
      |> assign(:tab, new_tab_state)

    {:noreply, socket}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
