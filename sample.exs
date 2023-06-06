
#DATA STRUCTURES:

#modules:
  # complied to bytecode before running
  # suppourts attributes @pi 3.14, @doc, for populating constants and dcoumentation

#maps: %{key => value, key: value} # second way is valid if key is a atom
  # supports bracket operator (map_name[]), and dot operator (man_name.key) if key is an atom
  #MapSet, MapSet.new([val, val ,val]) Its a set

#lists: [1, 3,"hello", []] # is actually a linked list
  # any method with "length" is O(n)
  # [head | tail], hd(), tl()
  # add to the front then reverse, the other way takes O(N^2)

#tuples: sort of like dynamic arrays (pointer to a list of void pointers)
  # not recomended to use for big lists of values for some reason
  # usually used to pass arguments
  # no bracket operator, need to use tuple methods

#binary: <<10, 30,4945 >>
  # by default 1 byte
  #  <> concat operator
  # strings are binary but String module has string methods

# atoms: :atom_name, true, false
  # Atom_name, Elixr.Atom_name also works
  # is a refrence to atom name in the atom table (one per runtime?)
  #  dont think its garbage collected


# functions: are first class, same as any other expression. can be passed around
  # pass helper functions to highe rorder functions, like Enum.each/2
  # anon = fn a, b, c -> a + b * c end, no parens, use .() to call
  # named functions are defined in a module and use parens
  # & capture operator, kinda of a wierd shortcut
      # anon = fn a, b, c -> a + b + c end  ====> anon = &(&1 + &2 + &3)
      # fn x -> IO.puts(x) end =====> &IO.puts/1 (nice for passing to HO func)
  # has closures. SAVES VALUE, EVEN IF VARIABLE CHANGES TO POINT SOMEWHERE ELSE

# Mich:
  # ranges 1..10, inclusive of both ends
  # keyword lists, used as arguments [{:atom, val}, {:atom, val}]
    # shortens to [atom: val, atom: val]
    # dont need brackets if last argument in function

  #parenthesis with with if the matches start on a seperate line
  # do: only with one line named functions
#------------------------------------------------------------------------------------
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

  def sum_list([]), do: 0
  def sum_list([head | tail]), do: head + sum_list(tail)

  def tail_sum_list(list,accum \\ 0) #set a default val for all definitions
  def tail_sum_list([],accum), do: accum
  def tail_sum_list([head | tail],accum), do: tail_sum_list(tail,head + accum)

  def error_check(n) when 100 / n > 10.0, do: "N is in the range (0, 10)"
  def error_check(n) when 100 / n <= 10.0, do: "N is outside the range (0, 10)"
  def error_check(n), do: "N is 0" #ignores the div by zero errors ^^^
  #Will be a error if no match!
end

# IO.puts(Mine.multi())
# Mine.mulitplex(:one)
# Mine.mulitplex(:false)
# Mine.mulitplex([1993])
# Mine.mulitplex('Hello')

# IO.puts(Mine.factorial(10))
# IO.puts(Mine.fib(45))
# IO.puts(Mine.sum_list([3,523,-223,34,24, 0.009]))

# IO.puts(Mine.error_check(0.1)) #inside
# IO.puts(Mine.error_check(5)) # inside
# IO.puts(Mine.error_check(10)) #outside
# IO.puts(Mine.error_check(-0.5)) #outside
# IO.puts(Mine.error_check(100)) #outside
# IO.puts(Mine.error_check(0)) #zero #ignores the div by zero errors

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

result = cond do
  # 10 / 0 -> :error
  false -> :false
  true -> :true
end
# IO.puts(result)

#case, basically cond but with pattern matching isntead of truthy expressions
exp = {10,0}
result = case exp do
  # {a,b} -> a / b
  _ -> :ok
end
# IO.puts(result)

#UNLIKE GUARDS, ERRORS PROPAGATE!


# with : Matches patterns until it hits do or a mismatch. In case of mismatch it returns the unmatched expression, in case of all matches it returns the last expression in the do block

func = fn
  x when x > 0 -> {:ok, x}
  x when true -> {:error, x} end


res = with {:ok, val1} <- func.(10),
    {:ok, val2} <- func.(0),
    {:ok, val2} <- func.(20),
    {:ok, val3} <- func.(30) do
    {val1, val2, val3}
end

# IO.inspect(res)

#--------------------------------------------------------------------------------
#ITERATION

# recursion
# Use tail recursion: the last thing the function does is call itself
  # makes it so the complier can safely pop the current stack frame, since we will never return to this function or need its scope again

# not tail recursion (looks like the complier optimizes it anyways)
# IO.inspect(Mine.sum_list(Enum.to_list(1..1600000)))

# tail recusion
# IO.inspect(Mine.tail_sum_list(Enum.to_list(1..1600000)))

defmodule Recur do

  def list_len(list, length \\ 0)
  def list_len([],length), do: length
  def list_len([head | tail], length), do: list_len(tail, length + 1)

  def range(from, to, list \\ [])
  def range(from, to, [from | tail]), do: [from | tail]
  def range(from, to, list), do: range(from, to - 1, [to | list])

  def positive(list, result \\ [])
  def positive([],result), do: Enum.reverse(result)
  def positive([head | tail], result) when head > 0, do: positive(tail,[head | result])
  def positive([head | tail], result) when head <= 0, do: positive(tail,result)


end

# IO.inspect(Recur.list_len(Enum.to_list(1..1567)))
# IO.inspect(Recur.range(-10, 30))
# IO.inspect(Recur.positive([-12,10,13,2,-3.4,4.3,0,13,9,9.0,-4]))


# Included Higher order functions:
# each, map, reduce, filter (similar to JS)
# Enum.reduce(enumerable, accum, func)
  # the function is called on every element of the enumerable, the result of that is the accumulator value for the the next function call on the next element
  #in the function call the the first argument is the element from the enumerable and the second is the accumulator
  # the final value is the value of the accumulator after the last element

# result = Enum.reduce(1..100, 0, &(&1 + &2))
# r = Enum.reduce(1..100,-73, &(&2 + &1 * 0))
# IO.inspect(r)


#Comprehensions: easy way to do nested loops

q = for x <- 1..3, do: x*x
w = for x <- 1..3, y <- 1..5, do: x*y
# IO.inspect(w)

# can use it to make any "collectable", pretty useful
mul_table = for x <- 1..9, y <- 1..9,
  # x <= y, #add filters
  into: %{}, do: {{x,y},x*y}

# IO.inspect(mul_table[{9,8}])

#Streams -lazy enumerable, just describes the computations that will be performed on some data, doesnt go through with it until a eager enumerator demands the data

#use it to save memory, no need to hold processed enumerables in memory if you dont need the data all at once

def large_lines!(path) do
  File.stream!(path) #returns a stream
  |> Stream.map(&(String.trim_trailing(&1,"\n")))
  |> Enum.filter(&(String.length(&1) > 80))
end
