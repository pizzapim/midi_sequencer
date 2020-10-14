defmodule MIDISeqWeb.PageLive do
  use MIDISeqWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    events = test_events()
    MIDIPlayer.generate_schedule(MIDISeq.Player, events, 3000)
    {:ok, assign(socket, events: test_events())}
  end

  @impl true
  def handle_event("start", _value, socket) do
    MIDIPlayer.play(MIDISeq.Player)

    {:noreply, socket}
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
