defmodule Grain.Grains.Grain do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Inspect, except: [:__meta__, :inserted_at, :updated_at, :id]}
  @derive {Jason.Encoder, except: [:__meta__, :inserted_at, :updated_at, :id]}
  schema "grains" do
    field :address, :string
    field :grade, :string
    field :latest_price, :string
    field :mark_number, :string
    field :market_name, :string
    field :starting_price, :string
    field :status, :string
    field :trade_amount, :string
    field :trantype, :string
    field :variety, :string
    field :year, :string
    field :request_no, :string
    field :storage_depot_name, :string
    field :store_no, :string

    timestamps()
  end

  @doc false
  def changeset(grain, attrs) do
    grain
    |> cast(attrs, [
      :store_no,
      :storage_depot_name,
      :request_no,
      :address,
      :mark_number,
      :grade,
      :latest_price,
      :market_name,
      :starting_price,
      :status,
      :trade_amount,
      :variety,
      :year,
      :trantype
    ])
    |> validate_required([
      :address,
      :mark_number,
      :grade,
      :latest_price,
      :market_name,
      :starting_price,
      :status,
      :trade_amount,
      :variety,
      :year,
      :trantype
    ])
    |> unique_constraint(:request_no)
  end
end
