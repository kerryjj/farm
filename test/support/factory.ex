defmodule Farm.Factory do
  use ExMachina.Ecto, repo: Farm.Repo

  def species_factory do
    %Farm.Animals.Species{}
  end
end