defmodule Farm.Animals.AnimalServiceGap do
  use Farm.Schema
  alias __MODULE__

  alias Farm.Animals.Animal
  alias Farm.Animals.ServiceGap

  schema "animal_service_gaps" do
    belongs_to :animal, Animal
    belongs_to :service_gap, ServiceGap
  end

  def changeset(%AnimalServiceGap{} = animal_service_gap, params) do
    animal_service_gap
    |> cast(params, [:animal_id, :service_gap_id])
  end
end