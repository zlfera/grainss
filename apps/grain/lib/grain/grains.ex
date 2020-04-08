defmodule Grain.Grains do
  @moduledoc """
  The Grains context.
  """

  import Ecto.Query

  alias Grain.Grains.Grain, as: Ggg
  alias Grain.Repo, as: Gr

  def year(g, year) do
    if year == "" do
      g
    else
      where(g, [a], a.year == ^year)
    end
  end

  def city(g, city) do
    if city == "" do
      g
    else
      city = "%#{city}%"
      or_where(g, [a], like(a.address, ^city))
    end
  end

  def search_grain(params) do
    limit =
      if params["limit"] == "" do
        200
      else
        String.to_integer(params["limit"])
      end

    Ggg
    |> limit(^limit)
    # |> offset(0)
    |> city(params["city1"])
    |> city(params["city2"])
    |> city(params["city3"])
    |> year(params["year"])
    |> order_by(desc: :inserted_at)
    |> Gr.all()
  end

  def search_grains(user_input) do
    Ggg
    |> order_by(desc: :inserted_at)
    |> Ecto.Query.limit(5000)
    # |> offset(i)
    |> Gr.all()
    |> Enum.reject(&(String.match?(&1.address, ~r/#{user_input}/) == false))
  end

  def list_grains do
    Ggg
    |> limit(3000)
    |> where([l], l.latest_price != "0")
    |> order_by(desc: :inserted_at)
    |> Gr.all()
  end

  def grains_list(x, y) do
    case y do
      "latest_price" ->
        Ggg
        |> where([l], l.latest_price != "0")
        |> limit(3000)
        |> order_by(desc: :inserted_at)
        |> Grain.Repo.all()

      "starting_price" ->
        [f] = from(p in Ggg, select: min(p.starting_price)) |> Gr.all()

        Ggg
        |> where(starting_price: ^f)
        # |> Ecto.Query.where([g], g.latest_price != "0")
        |> order_by(desc: :inserted_at)
        |> Gr.all()

      "year" ->
        Ggg
        |> where(year: ^x)
        |> limit(3000)
        # |> Ecto.Query.where([g], g.latest_price != "0")
        |> order_by(desc: :inserted_at)
        |> Gr.all()

      "address" ->
        [xx, _] = x |> String.split("(")

        Ggg
        |> where(address: ^xx)
        |> limit(3000)
        # |> Ecto.Query.where([g], g.latest_price != "0")
        |> order_by(desc: :inserted_at)
        |> Gr.all()

      "variety" ->
        Ggg
        |> where(variety: ^x)
        |> limit(3000)
        # |> Ecto.Query.where([g], g.latest_price != "0")
        |> order_by(desc: :inserted_at)
        |> Gr.all()
    end
  end
end
