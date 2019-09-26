defmodule Farm.Animals.Species do
  use Farm.Schema

  alias Farm.Animals.Animal

  schema "species" do
    field :name, :string
    has_many :animals, Animal

    timestamps()
  end

  def changeset(%__MODULE_{} = species, params) do
    species
    |> cast(params, [:name])
  end
end