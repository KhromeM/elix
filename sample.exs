

defmodule Mine do
  def yell(text) do
    IO.puts(String.upcase(text))
  end

  def multi(mystery \\ nil) do
    case mystery do
      nil -> "Wow you entered nothing!"
      1 -> "Youre one of a kind!"
      2 -> "Two heads are better than one."
      3 -> "Third times the charm!"
      _ -> "Please stop."
    end
  end
end

IO.puts(Mine.multi())
