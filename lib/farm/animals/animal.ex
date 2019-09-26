defmodule Farm.Animals.Animal do
  use Farm.Schema

  alias Farm.Animals.Species
  alias Farm.Animals.ServiceGap
  alias Farm.Accounts.User

  @derive {Jason.Encoder, only: [:name, :species_id]}
  schema "animals" do
    field :name, :string
    field :status, :string

    belongs_to :owner, User
    belongs_to :species, Species
    many_to_many :service_gaps, ServiceGap, join_through: "animal_service_gaps"

    timestamps()
  end

  def changeset(params) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(%__MODULE__{} = animal, params) do
    animal
    |> cast(params, [:name, :species_id])
  end
end