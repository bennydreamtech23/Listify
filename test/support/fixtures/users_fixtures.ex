defmodule Listify.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Listify.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> Listify.Users.create_user()

    user
  end
end
