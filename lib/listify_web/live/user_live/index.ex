defmodule ListifyWeb.UserLive.Index do
  use ListifyWeb, :live_view
  alias Listify.Users.User

  alias Listify.Users

  @impl true
  def mount(_params, _session, socket) do

    changeset = Users.change_user(%User{})
    users = Users.list_users()

    socket =
      socket
      |> assign_form(changeset)
      |>assign(:tab, "register")
      |> assign(:users, users)


    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    IO.inspect(user_params, label: "user_params")

    changeset = Users.change_user(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  @impl true


  def handle_event("submit", %{"user" => user_params}, socket) do
    changeset = Users.change_user(%User{}, user_params)

    if changeset.valid? do
      case Users.create_user(user_params) do
        {:ok, user} ->
          socket =
            socket
            |> put_flash(:info, "Welcome #{user.name}!")
            |> push_navigate(to: ~p"/set_session/#{user.name}")

          {:noreply, socket}

        {:error, _reason} ->
          {:noreply, socket}
      end
    else
      {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
    end
  end



  def handle_event("validate-login", %{"user" => user_params}, socket) do
    IO.inspect(user_params, label: "user_params")

    changeset = Users.change_user_email(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  @impl true
  def handle_event("submit-login", %{"user" => user_params}, socket) do
    changeset = Users.change_user_email(%User{}, user_params)

    if changeset.valid? do
      users = socket.assigns.users
      email_to_check = user_params["email"]

      # Find the user with the matching email
      case Enum.find(users, fn user -> user.email == email_to_check end) do
        nil ->
          # User not found
          {:noreply,
           socket
           |> put_flash(:error, "No user found with the provided email.")}

        user ->

          socket =
          socket
          |> put_flash(:info, "User found. Welcome back, #{user.name}!")
          |> push_navigate(to: ~p"/set_session/#{user.name}")
          {:noreply, socket}
      end
    else
      # Handle invalid changeset
      {:noreply, assign(socket, :changeset, changeset)}
    end
  end



  def handle_event("register", _params, socket) do
    {:noreply, assign(socket, :tab, "register")}
    end




  def handle_event("login", _params, socket) do
    {:noreply, assign(socket, :tab, "login")}
    end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

end
