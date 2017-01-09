### Overview
srch.ex is an Elixir module which searches all files in a given directory for a given string. It searches each file in parallel by spawning a new Elixir process for each file in the directory. I have also left the non-parallel implementation of the search function for comparison purposes.

### Try it out
You must have Elixir and Erlang installed on your machine to use this module.

1. Compile the Srch module: `\> elixirc srch.ex`

2. Run the provided script: `\> elixir find_string_in_dir.exs`

3. Enter the directory that you want to search through and the string you want to search for as the script prompts you.

4. The script will print out the time it took to complete the search, and each line of text it found which contains the provided string:

[command line example](./cmd-example.png "command line example")
