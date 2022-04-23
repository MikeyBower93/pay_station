defmodule PayStation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PayStation.Repo,
      # Start the Telemetry supervisor
      PayStationWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PayStation.PubSub},
      # Start the Endpoint (http/https)
      PayStationWeb.Endpoint,
      # Start a worker by calling: PayStation.Worker.start_link(arg)
      # {PayStation.Worker, arg}
      %{
        id: Kaffe.GroupMemberSupervisor,
        start: {Kaffe.GroupMemberSupervisor, :start_link, []},
        type: :supervisor
      },
      {PayStation.Payments.PaymentFetcher, %{}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PayStation.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PayStationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
