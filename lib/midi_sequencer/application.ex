defmodule MIDISeq.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MIDISeq.Repo,
      # Start the Telemetry supervisor
      MIDISeqWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MIDISeq.PubSub},
      # Start the Endpoint (http/https)
      MIDISeqWeb.Endpoint,
      {MIDIPlayer, [name: MIDISeq.Player]}
      # Start a worker by calling: MIDISeq.Worker.start_link(arg)
      # {MIDISeq.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MIDISeq.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MIDISeqWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
