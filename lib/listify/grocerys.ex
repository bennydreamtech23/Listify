defmodule Listify.Grocerys do
  @moduledoc """
  The Grocerys context.
  """

  import Ecto.Query, warn: false
  alias Listify.Repo

  alias Listify.Grocerys.Grocery

  @doc """
  Returns the list of groceries.

  ## Examples

      iex> list_groceries()
      [%Grocery{}, ...]

  """
  def list_groceries do
    Repo.all(Grocery)
  end


  def list_groceries(user_id) do
    from(g in Grocery, where: g.user_id == ^user_id)
    |> Repo.all()
  end

  @doc """
  Gets a single grocery.

  Raises `Ecto.NoResultsError` if the Grocery does not exist.

  ## Examples

      iex> get_grocery!(123)
      %Grocery{}

      iex> get_grocery!(456)
      ** (Ecto.NoResultsError)

  """
  def get_grocery!(id), do: Repo.get!(Grocery, id)

  @doc """
  Creates a grocery.

  ## Examples

      iex> create_grocery(%{field: value})
      {:ok, %Grocery{}}

      iex> create_grocery(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_grocery(attrs \\ %{}) do
    %Grocery{}
    |> Grocery.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a grocery.

  ## Examples

      iex> update_grocery(grocery, %{field: new_value})
      {:ok, %Grocery{}}

      iex> update_grocery(grocery, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_grocery(%Grocery{} = grocery, attrs) do
    grocery
    |> Grocery.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a grocery.

  ## Examples

      iex> delete_grocery(grocery)
      {:ok, %Grocery{}}

      iex> delete_grocery(grocery)
      {:error, %Ecto.Changeset{}}

  """
  def delete_grocery(%Grocery{} = grocery) do
    Repo.delete(grocery)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking grocery changes.

  ## Examples

      iex> change_grocery(grocery)
      %Ecto.Changeset{data: %Grocery{}}

  """
  def change_grocery(%Grocery{} = grocery, attrs \\ %{}) do
    Grocery.changeset(grocery, attrs)
  end
end
