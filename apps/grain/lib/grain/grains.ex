defmodule Grain.Grains do
  @moduledoc """
  The Grains context.
  """

  import Ecto.Query

  alias Grain.Grains.Grain, as: Ggg
  alias Grain.Repo, as: Gr

  def bool(g, bool) do
    if bool in ["", nil, "false"] do
      g
    else
      where(g, [a], a.status == "成交")
    end
  end

  def year(g, year) do
    if year in ["", nil] do
      g
    else
      where(g, [a], a.year == ^year)
    end
  end

  def city(g, city) do
    if String.trim(city) in ["", nil] do
      g
    else
      city = "%#{city}%"

      or_where(g, [a], like(a.address, ^city))
      |> or_where([a], like(a.storage_depot_name, ^city))
      |> or_where([a], like(a.market_name, ^city))
    end
  end

  def limit_num(g, l) do
    if l in ["", nil] do
      limit(g, 50)
    else
      l = String.to_integer(l)
      limit(g, ^l)
    end
  end

  def page(g, params) do
    page =
      if params["page"] in ["", nil] do
        1
      else
        String.to_integer(params["page"])
      end

    l =
      if params["limit"] in ["", nil] do
        50
      else
        String.to_integer(params["limit"])
      end

    g
    |> offset((^page - 1) * ^l)
    |> limit_num(params["limit"])
  end

  def search_grain(params) do
    gg =
      Ggg
      # (desc: :inserted_at)
      |> order_by(desc: :id)
      |> city(params["city1"])
      |> city(params["city2"])
      |> city(params["city3"])
      |> year(params["year"])
      |> bool(params["bool"])

    ggg = page(gg, params)
    {length(Gr.all(gg)), Gr.all(ggg)}
  end

  def search_grains(user_input) do
    Ggg
    |> order_by(desc: :id)
    |> Ecto.Query.limit(500)
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
