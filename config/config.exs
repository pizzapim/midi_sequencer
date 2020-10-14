# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :midi_sequencer,
  namespace: MIDISeq,
  ecto_repos: [MIDISeq.Repo]

# Configures the endpoint
config :midi_sequencer, MIDISeqWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fYuotKiCE6taZ/jce95BgdGEacvUlsrqFvFT/L8slfw/pznQp8DJ7Ro17SIK6UFT",
  render_errors: [view: MIDISeqWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MIDISeq.PubSub,
  live_view: [signing_salt: "EyIkzsut"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
