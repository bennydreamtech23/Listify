defmodule Listify.Grocerys.Grocery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groceries" do
    field :description, :string
    field :name, :string
    field :quantity, :integer
    field :user_id, :id
    field :category_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(grocery, attrs) do
    grocery
    |> cast(attrs, [:name, :description, :quantity])
    |> validate_required([:name, :description, :quantity])
  end
end
