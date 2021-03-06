defmodule Grain.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  # use Supervisor
  use Application

  def start(_type, _args) do
    children = [
      Grain.Repo,
      {Phoenix.PubSub, name: Grain.PubSub},
      #      Grain.Tasks,
      # worker(Grain.Scheduler, []),
      Grain.Scheduler
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Grain.Supervisor)
  end
end
