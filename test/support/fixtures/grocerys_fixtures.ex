defmodule Listify.GrocerysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Listify.Grocerys` context.
  """

  @doc """
  Generate a grocery.
  """
  def grocery_fixture(attrs \\ %{}) do
    {:ok, grocery} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        quantity: 42
      })
      |> Listify.Grocerys.create_grocery()

    grocery
  end
end
