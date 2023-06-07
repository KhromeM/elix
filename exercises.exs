
defmodule LLines do

  #1 lines_lengths!/1 that takes a file path and returns a list of numbers, with each number representing the length of the corresponding line from the file.
  def lines_length!(path) do
    File.stream!(path)
    |> Stream.map(&(String.trim_trailing(&1,"\n")))
    |> Enum.map(&String.length/1)
  end

  #2 longest_line_length!/1 that returns the length of the longest line in a file.
  def longest_line_length!(path) do
    File.stream!(path)
    |> Stream.map(&(String.trim_trailing(&1,"\n")) |> String.length())
    |> Enum.max()
    # |> Enum.reduce(&(max(&1,&2)))

  end

  #3 longest_line!/1 that returns the contents of the longest line in a file.
  def longest_line!(path) do
    length = longest_line_length!(path)
    File.stream!(path)
    |> Stream.map(&(String.trim_trailing(&1,"\n")))
    |> Enum.filter(&(String.length(&1) == length))
    |> hd()
  end

  #4 words_per_line!/1 that returns a list of numbers, with each number representing the word count in a file.
  def words_per_line(path) do
    File.stream!(path)
    |> Stream.map(&(String.trim_trailing(&1,"\n")))
    |> Enum.map(&(String.split(&1)) |> length())
  end

end

IO.inspect(LLines.lines_length!("./text.txt")) #works
IO.inspect(LLines.longest_line_length!("./text.txt")) #works
IO.inspect(LLines.longest_line!("./text.txt")) #works
IO.inspect(LLines.words_per_line("./text.txt")) #works
