defmodule Woombat.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Woombat.Repo, []),
      # Start the endpoint when the application starts
      supervisor(WoombatWeb.Endpoint, []),
      supervisor(WoombatWeb.Presence, []),
      # Start your own worker by calling: Woombat.Worker.start_link(arg1, arg2, arg3)
      # worker(Woombat.Worker, [arg1, arg2, arg3]),
      worker(Woombat.Tweeter, []),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Woombat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WoombatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
