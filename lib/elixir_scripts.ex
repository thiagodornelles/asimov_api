defmodule ElixirScripts do
  @elixir_dir "lib/elixir_exs/"

  def elixir_call(file) do
    file = String.replace(file, "../", "")
    Code.eval_file(@elixir_dir <> file)
  end
end
