

defmodule Mine do
  def yell(text) do
    IO.puts(String.upcase(text))
  end
end

text = "Hi my name is Mustafa!"

Mine.yell(text)
