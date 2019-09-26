defmodule Farm.Animals.Repository do
  @moduledoc "DB access required by the business logic in the Animals bounded context"
  alias Farm.Animals.Animal
  alias Farm.Animals.ServiceGap
  alias Farm.Animals.AnimalServiceGap
  alias Farm.Repo

  import Ecto.Query, only: [from: 2]

  require Logger

  def animal(animal_id, preload \\ []) do
    Repo.get!(Animal, animal_id)
    |> Repo.preload(preload)
  end

  def animal_by_name(animal_name) do
    Repo.get_by!(Animal, name: animal_name)
  end

  def create(params) do
    Animal.changeset(params)
    |> Repo.insert!()
  end

  def batch_create(animals) when is_list(animals) do
    animals_with_timestamps = add_timestamps(animals)

    case Repo.insert_all(Animal, animals_with_timestamps) do
      {_, nil} -> []
      {_, animals} -> animals
    end
  end

  def update_species_status(species, status) do
    query = from a in Animal,
      where: a.species == ^species.id

    Repo.update_all(Animal, set: [status: status])
  end

  def create_service_gap(%Animal{} = animal, %{reason: _, started_at: _, ended_at: _} = params) do
    service_gap = ServiceGap.changeset(%ServiceGap{}, params)
    |> Repo.insert!()

    AnimalServiceGap.changeset(%AnimalServiceGap{}, %{animal_id: animal.id, service_gap_id: service_gap.id})
    |> Repo.insert!()

    service_gap
  end

  defp add_timestamps(animals) do
    now = DateTime.utc_now()

    for a <- animals do
      a
      |> Map.put(:inserted_at, now)
      |> Map.put(:updated_at, now)
    end
  end
end