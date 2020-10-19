defmodule MIDISeqWeb.Component.ChannelLive do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end
end
