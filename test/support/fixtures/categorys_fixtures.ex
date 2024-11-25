defmodule Listify.CategorysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Listify.Categorys` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Listify.Categorys.create_category()

    category
  end
end
