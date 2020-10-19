defmodule MIDISeqWeb.DashboardLive do
  use MIDISeqWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, channels: mock_channels(), current_channel_id: nil)}
  end

  @impl true
  def handle_event("change_current_channel", %{"channel_id" => channel_id}, socket) do
    {:noreply, assign(socket, current_channel_id: channel_id)}
  end

  defp mock_channels do
    %{
      0 => %{program: 1},
      1 => %{program: 2},
      2 => %{program: 40}
    }
  end
end
