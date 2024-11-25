defmodule Listify.Repo.Migrations.CreateGroceries do
  use Ecto.Migration

  def change do
    create table(:groceries) do
      add :name, :string
      add :description, :string
      add :quantity, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:groceries, [:user_id])
    create index(:groceries, [:category_id])
  end
end
