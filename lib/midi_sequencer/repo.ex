defmodule MIDISeq.Repo do
  use Ecto.Repo,
    otp_app: :midi_sequencer,
    adapter: Ecto.Adapters.Postgres
end
