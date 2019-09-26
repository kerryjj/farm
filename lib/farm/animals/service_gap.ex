defmodule Farm.Animals.ServiceGap do
  use Farm.Schema
  alias __MODULE__

  schema "service_gaps" do
    field :reason, :string

    field :started_at, :utc_datetime_usec
    field :ended_at, :utc_datetime_usec

    timestamps()
  end

  def changeset(%ServiceGap{} = service_gap, params) do
    service_gap
    |> cast(params, [:reason, :started_at, :ended_at])
  end
end