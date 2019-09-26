defmodule Farm.Animals do
  @moduledoc "Bounded Context for Animals"

  alias Farm.Animals.Repository, as: AnimalRepo
  alias Farm.Animals.Animal
  alias Farm.Animals.Species

  def animal(animal_id) do
    AnimalRepo.animal(animal_id)
  end

  def animal_with_species(animal_id) do
    AnimalRepo.animal(animal_id, [:species])
  end

  def animal_by_name(animal_name) do
    AnimalRepo.animal_by_name(animal_name)
  end

  def create_animal(params) do
    AnimalRepo.create(params)
  end

  def create_animals(animal_params) when is_list(animal_params) do
    AnimalRepo.batch_create(animal_params)
  end

  def lost_species(%Species{} = species) do
    AnimalRepo.update_species_status(species, "lost")
  end

  def report_service_gap(%Animal{} = animal, reason, %Date{} = start_date, %Date{} = end_date) do
    params = %{reason: reason, started_at: to_datetime(start_date), ended_at: to_datetime(end_date)}
    AnimalRepo.create_service_gap(animal, params)
  end

  defp to_datetime(%Date{} = date) do
    {:ok, datetime, _} = "#{Date.to_iso8601(date)}T00:00:00Z"
    |> DateTime.from_iso8601()
    datetime
  end
end