defmodule ShoppingList do
  use GenServer

  # Client
  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def add(pid, item) do
    GenServer.cast(pid, item)
  end

  def view(pid) do
    GenServer.call(pid, :view)
  end

  def add_with_reply(pid, item) do
    GenServer.call(pid, {:add, item})
  end

  def remove(pid, item) do
    GenServer.cast(pid, {:remove, item})
  end
  def stop(pid) do
    GenServer.stop(pid, :normal, :infinity)
  end
  # Server
  def terminate(_reason, list) do
    IO.puts("We are all done shopping.")
    IO.inspect(list)
    :ok
  end
  def init(state) do
    {:ok, state}
  end

  def handle_cast({:remove, item},  state) do
    IO.puts("Removing #{item} from the shopping list")
    updated_state = List.delete(state, item)
    {:noreply, updated_state}
  end

  def handle_cast(item, state) do
    IO.puts("Adding #{item} to the shopping list")
    updated_state = [item | state]
    {:noreply, updated_state}
  end

  def handle_call(:view, from, state) do
    IO.inspect(from, label: "from")
    {:reply, state, state}
  end

  def handle_call({:add, item}, from, state) do
    IO.puts("Adding #{item} to the shopping list")
    updated_state = [item | state]
    {:reply, updated_state, updated_state}
  end
end
