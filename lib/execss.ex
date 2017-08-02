defmodule Execss do
  require Logger
  use GenServer

  @render_tick_limit 1000
  @play_scene [&Execss.render_system/1]
  @keys ['w', 'a', 's', 'd']

  #SERVER CODE
  def start_link(state \\ %{scene: @play_scene}) do
    GenServer.start_link(__MODULE__, state, [name: __MODULE__])
  end

  def handle_cast({:input, data}, state) do
    new_state = state
    |> Map.update(:input, [data], fn (list) -> list ++ [data] end)
    |> tick
    {:noreply, new_state}
  end

  def input(data) do
    GenServer.cast(__MODULE__, {:input, data})
  end

  #GAME CODE
  def render_system(game_state = %{render: render_state}) when not is_integer(render_state) do
    Logger.warn("Render state recked")
    game_state
  end

  def render_system(game_state) do
    IO.puts(inspect(game_state))
    Map.update(game_state, :render, 0, fn(render_state) -> rem(render_state + 1, @render_tick_limit) end)
  end

  def run do
    input(IO.gets("Input: "))
    run()
  end

  def tick(game_state) do
    Enum.reduce(game_state.scene, game_state, fn(system, state) -> system.(state) end)
  end
end
