defmodule Farm.Repo.Migrations.CreateAnimalAndSpecies do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :name, :string
      add :email, :string

      timestamps()
    end

    create table(:species) do
      add :name, :string

      timestamps()
    end

    create table(:animals) do
      add :name, :string
      add :status, :string

      add :species_id, references(:species), null: false
      add :owner_id, references(:users)

      timestamps()
    end

    create table(:service_gaps) do
      add :reason, :string
      add :started_at, :utc_datetime_usec
      add :ended_at, :utc_datetime_usec

      timestamps()
    end

    create table(:animal_service_gaps) do
      add :animal_id, references(:animals), null: false
      add :service_gap_id, references(:service_gaps), null: false
    end
  end

  def down do
    drop table(:animal_service_gaps)
    drop table(:service_gaps)
    drop table(:animals)
    drop table(:species)
    drop table(:users)
  end
end
