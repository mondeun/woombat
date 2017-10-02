defmodule WoombatWeb.RoomChannel do
  use WoombatWeb, :channel

  alias WoombatWeb.Presence
  alias Woombat.Coherence.User
  alias Woombat.Repo
  alias Woombat.Tweeter

  def join("room", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    user = Repo.get(User, socket.assigns.user_id)

    {:ok, _} = Presence.track(socket, user.name, %{
          online_at: inspect(System.system_time(:seconds))})
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_in("message:new", %{"message" => "/shout"} = payload, socket) do
    broadcast socket, "message:new", payload
    {:noreply, socket}
  end

  def handle_in("message:new", %{"message" => "/flamewar"} = payload, socket) do
    message = Tweeter.read

    broadcast socket, "message:new", %{user: "Donald Trump", message: message}
    {:noreply, socket}
  end

  def handle_in("message:new", %{"message" => "/ping"} = payload, socket) do
    push socket, "message:new", %{user: "SYSTEM", message: "pong"}
    {:noreply, socket}
  end

  def handle_in("message:new", payload, socket) do
    user = Repo.get(User, socket.assigns.user_id)

    broadcast socket, "message:new", %{user: user.name, message: payload["message"]}
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
