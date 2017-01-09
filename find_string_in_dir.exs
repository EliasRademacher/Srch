dir = IO.gets("Enter a folder to search in: ")
string = IO.gets("Enter a word to search for: ")

unit = 1000 # milliseconds
start_time = :erlang.system_time(unit)

results = Srch.findInDirParallel(dir, string)
# results = Srch.findInDir(dir, string)

end_time = :erlang.system_time(unit)
relative_time = end_time - start_time

IO.puts "\nCompleted in " <> to_string(relative_time) <> " milliseconds.\n"
IO.puts to_string results
