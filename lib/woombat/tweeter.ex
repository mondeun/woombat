defmodule Woombat.Tweeter do
  use GenServer

  # API

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :tweets)
  end

  def read do
    GenServer.call(:tweets, :read)
  end

  # SERVER

  def init do
    {:ok}
  end

  def handle_call(:read, _from, _tweets) do
    tweet = ExTwitter.search("from:realdonaldtrump", count: 50)
    |> Enum.map(fn(tweet) -> tweet.text end)
    |> Enum.random

    {:reply, tweet, tweet}
  end
end
