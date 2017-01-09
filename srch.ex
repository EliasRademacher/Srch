defmodule Srch do
  @moduledoc """
   Parallel approach to searching through a directory.
  """

  @doc """
    Searches the given document for occurrences of the provided string.
    Returns a list of the lines which contain the given string.
  """
  def find(document, string) do
    File.stream!(String.trim(document), [:read, :utf8])
    |> Stream.filter(fn(s) -> String.contains?(s, String.trim(string)) end)
    |> Enum.to_list
    |> to_string
  end

  @doc """
    Searches every file in the given directory for the given string.
    Returns a list of strings containing occurences of keyword.
  """
  def findInDir(dir, string) do
    for file <- File.ls!(String.trim(dir)),
        !File.dir?(get_path(dir, file)) do
          result = find(get_path(dir, file), string)
          "Results found in "
            <> file
            <> ":\n"
            <> to_string result
            <> "\n"
    end
  end

  @doc """
    Searches every file in the given directory for the given string.
    Returns a list of strings containing occurences of keyword.

    Creates a new process for every file in the directory.
  """
  def findInDirParallel(dir, string) do
    # TODO: Only spawn as many processes as you have processors.
    num_processors = :erlang.system_info(:logical_processors_available)
    
    for process <- spawnSearchers(dir, string), do:
        Task.await(process, :infinity)
  end

  defp spawnSearchers(dir, string) do
    processes = []
    for file <- File.ls!(String.trim(dir)),
        !File.dir?(get_path(dir, file)) do
          process = Task.async(Srch, :find, [get_path(dir, file), string])
          processes ++ process
    end
  end

  defp get_path(dir, file) do
    Path.join(String.trim(dir), file)
  end

end
