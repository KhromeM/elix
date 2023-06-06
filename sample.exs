

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


  def mulitplex(input) when is_boolean(input) do
    IO.puts("You entered a boolean!")
  end
  def mulitplex(input) when is_atom(input) do
    IO.puts("You entered an atom!")
  end
  def mulitplex(input) when is_binary(input) do
    IO.puts("You entered binary!")
  end
  def mulitplex(input) when is_list(input) do
    IO.puts("You entered a list!")
  end

  def factorial(n) when n == 0, do: 1
  def factorial(n), do: n * factorial(n-1)

  def fib(n) when n == 0, do: 1
  def fib(n) when n == 1, do: 1
  def fib(n), do: fib(n-1) + fib(n-2)
end

# IO.puts(Mine.multi())
# Mine.mulitplex(:one)
# Mine.mulitplex(:false)
# Mine.mulitplex([1993])
# Mine.mulitplex('Hello')

# IO.puts(Mine.factorial(10))
IO.puts(Mine.fib(45))

anon = fn
  x when x > 0 -> :positive
  x when x == 0 -> :zero
  x when x < 0 -> :negative
end
# Enum.each([anon.(10),anon.(0), anon.(-234)], &IO.puts/1)


#if exp, do: x, else: y
#cond = switch statement. Evals the first true exp, have a default to error handle
#cond do
  #exp1 -> x
  #exp2 -> y
  #exp3 -> z
  #true -> :error
#end
