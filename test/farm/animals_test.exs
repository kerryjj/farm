defmodule Farm.Animals.RepositoryTest do
  use Farm.DataCase

  alias Farm.Animals

  describe "Given a single species" do
    setup [:with_species]

    test "Create an animal that belongs to a species", %{species: species} do
      animal = Animals.create_animal(%{name: "Bob", species_id: species.id})
      assert animal.name == "Bob"
      assert animal.species_id == species.id
    end

    test "Batch create animals", %{species: species} do
      animals = [
        %{name: "Bob", species_id: species.id},
        %{name: "Jane", species_id: species.id}
      ]

      Animals.create_animals(animals)

      jane = Animals.animal_by_name("Jane")
      assert jane.name == "Jane"
    end

    test "Report service gap", %{species: species} do
      animal = Animals.create_animal(%{name: "Bob", species_id: species.id})
      start_date = ~D[2019-01-01]
      end_date = ~D[2019-01-25]

      gap = Animals.report_service_gap(animal, "some reason", start_date, end_date)

      assert gap.reason == "some reason"
      assert DateTime.to_iso8601(gap.started_at) == "2019-01-01T00:00:00.000000Z"
    end

    test "Mark all animals of a specific species as being as being lost", %{species: species} do
      another_species = insert(:species, %{name: "Cow"})

      Animals.create_animal(%{name: "Bob", species_id: species.id})
      Animals.create_animal(%{name: "Jane", species_id: species.id})
      Animals.create_animal(%{name: "Yvonne", species_id: another_species.id})

      Animals.lost_species(species)

      bob = Animals.animal_by_name("Bob")
      assert bob.status == "lost"

      yvonne = Animals.animal_by_name("Yvonne")
      assert yvonne.status != "lost"
    end
  end

  defp with_species(_context) do
    %{species: insert(:species, %{name: "Sheep"})}
  end
end