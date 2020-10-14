defmodule MIDISeqWeb.PageLive do
  use MIDISeqWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    events = test_events()
    MIDIPlayer.generate_schedule(MIDISeq.Player, events, 3000)
    {:ok, assign(socket, events: test_events(), adding: nil)}
  end

  @impl true
  def handle_event("start", _value, socket) do
    MIDIPlayer.play(MIDISeq.Player)

    {:noreply, socket}
  end

  def handle_event("toggle-note-form", _value, %{assigns: %{adding: :note}} = socket) do
    {:noreply, assign(socket, adding: nil)}
  end

  def handle_event("toggle-note-form", _value, socket) do
    {:noreply, assign(socket, adding: :note)}
  end

  def handle_event(
        "toggle-change-program-form",
        _value,
        %{assigns: %{adding: :change_program}} = socket
      ) do
    {:noreply, assign(socket, adding: nil)}
  end

  def handle_event("toggle-change-program-form", _value, socket) do
    {:noreply, assign(socket, adding: :change_program)}
  end

  def handle_event(
        "save_note",
        %{
          "note" => %{
            "channel" => channel,
            "tone" => tone,
            "velocity" => velocity,
            "end_time" => end_time,
            "start_time" => start_time
          }
        },
        %{assigns: %{events: events}} = socket
      ) do
    channel = String.to_integer(channel)
    tone = String.to_integer(tone)
    velocity = String.to_integer(velocity)
    end_time = String.to_integer(end_time)
    start_time = String.to_integer(start_time)
    event = MIDIPlayer.Event.note(channel, tone, start_time, end_time, velocity)
    events = [event | events]
    MIDIPlayer.generate_schedule(MIDISeq.Player, events, 3000)
    {:noreply, assign(socket, events: events, adding: nil)}
  end

  def handle_event(
        "save_change_program",
        %{
          "change_program" => %{
            "channel" => channel,
            "time" => time,
            "program" => program
          }
        },
        %{assigns: %{events: events}} = socket
      ) do
    channel = String.to_integer(channel)
    time = String.to_integer(time)
    program = String.to_integer(program)
    event = MIDIPlayer.Event.change_program(channel, time, program)
    events = [event | events]
    MIDIPlayer.generate_schedule(MIDISeq.Player, events, 3000)
    {:noreply, assign(socket, events: events, adding: nil)}
  end

  defp test_events do
    change1 = MIDIPlayer.Event.change_program(0, 0, 15)
    piano = MIDIPlayer.Event.note(0, 60, 0, 1000, 127)
    change2 = MIDIPlayer.Event.change_program(0, 1000, 42)
    violin1 = MIDIPlayer.Event.note(0, 67, 1000, 3000, 127)
    violin2 = MIDIPlayer.Event.note(0, 64, 1000, 3000, 127)
    [change1, piano, change2, violin1, violin2]
  end
end
