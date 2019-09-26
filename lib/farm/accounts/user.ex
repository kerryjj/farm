defmodule Farm.Accounts.User do
  use Farm.Schema

  alias Farm.Animals.Animal

  schema "users" do
    field :name, :string
    field :email, :string

    has_many :animals, Animal, foreign_key: :owner_id

    timestamps()
  end
end