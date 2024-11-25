# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Listify.Repo.insert!(%Listify.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.



# priv/repo/seeds.exs

alias Listify.Repo
alias Listify.Categorys
alias Listify.Categorys.Category

# Define a list of categories to be added
categories = [
  %{"name" => "Beverages"},
  %{"name" => "Cereals"},
  %{"name" => "Electronics"},
  %{"name" => "Fashion"},
  %{"name" => "Furniture"},
  %{"name" => "Personal care"}
]

# Insert categories into the database
Enum.each(categories, fn category_attrs ->
  case Categorys.create_category(category_attrs) do
    {:ok, _category} -> IO.puts("Category #{category_attrs["name"]} created successfully.")
    {:error, changeset} -> IO.puts("Failed to create category #{category_attrs["name"]}: #{inspect(changeset)}")
  end
end)
