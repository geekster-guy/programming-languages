# First elixir homework
# Working with lists in elixir
#
# Yair Camacho
# 19/08/2022

defmodule Hw.Lists do
  @moduledoc """
  Provides a group of functions to proccess lists in elixir.
  """

  @doc """
  Takes a list, and two elements A and B as arguments. It will return a new list
  with any appearance of A substituted for B, and vice versa. Any other elements
  are kept in the same place.

  ## Parameters
    - list: A list with any amount of elements
    - first_element: Element that will be swaped with the third argument
    - second_element: Element that will be swaped with the second argument

  ## Examples
    iex> Hw.Lists.swapper([:a, :b, :c, :b, :d], :a, :b)
    [:b, :a, :c, :a, :d]
  """
  def swapper(list, first_element, second_element) do
    cond do
      list == [] -> list
      hd(list) == first_element
        -> [second_element | swapper(tl(list), first_element, second_element)]
      hd(list) == second_element
        -> [first_element | swapper(tl(list), first_element, second_element)]
      true -> [hd(list) | swapper(tl(list), first_element, second_element)]
    end
  end

  @doc """
  Takes a list of 'two-element' tuples and invert the order of the elements
  inside every tuple.

  ## Parameters
    - list: A list with any amount of 'two-element' tuples

  ## Examples
    iex> Hw.Lists.invert_pairs([{1, 2}, {:a, :b}, {"Monday", "Tuesday"}])
    [{2, 1}, {:b, :a}, {"Tuesday", "Monday"}]
  """
  def invert_pairs(list), do: travel_array(list, [])

  # Function to travel through the list
  defp travel_array([], array), do: array
  defp travel_array([head | tail], array),
    do: travel_array(tail, array ++ [invert_tuple(head)])
  # Invert elements inside the tuple
  defp invert_tuple({a, b}), do: {b, a}

  @doc """
  Takes a list as arguments. The list may contain nested lists. It will return
  another list, where the elements are in reverse order. The elements in any
  nested list must also reverse their order.

  ## Parameters
    - list: A list with any amount of nested lists

  ## Examples
    iex> Hw.Lists.deep_reverse([[1, 2, 3], [4, 5, 6], [:a, :b, :c]])
    [[:c, :b, :a], [6, 5, 4], [3, 2, 1]]
  """
  def deep_reverse(list), do: my_reverse(list, [])

  # If the list is empty, return the inverted list (base case)
  defp my_reverse([], revList), do: revList
  # Reverse function when there is a nested list
  defp my_reverse([head | tail], revList) when is_list(head),
    do: my_reverse(tail, [deep_reverse(head) | revList])
  # Reverse function for a normal list
  defp my_reverse([head | tail], revList),
    do: my_reverse(tail, [head | revList])

  @doc """
  Takes a list of numbers and returns the average.

  ## Parameters
    - list: List with any amount of numbers

  ## Examples
    iex> Hw.Lists.mean([1.7, 4.5, 0, 2.0, 3.4, 5, 2.5, 2.2, 1.2])
    2.5
  """
  def mean(list), do: average(list, 0, 0)
  # If the list is empty, return 0 (base case)
  defp average([], 0, 0), do: 0

  # When it gets to the end of the list, divide the total
  # sum between the number of elements in the list
  defp average([], count, sum), do: (sum / count)
  defp average([head | tail], count, sum),
    do: average(tail, (count + 1), (sum + head))

  @doc """
  Takes a list of numbers and computes the standard deviation.

  ## Parameters
    - list: A list with any amount of numbers

  ## Examples
    iex> Hw.Lists.std_dev([4, 8, 15, 16, 23, 42])
    12.315302134607444
  """
  def std_dev([]), do: 0 # When the list is empty, return 0 (base case)
  def std_dev(list) do
    # First, we get how many elements are in the list
    elementCount = Enum.count(list)
    # Then, we get the average of the list
    avrg = mean(list)
    # Finally, we compute the ecuation
    :math.sqrt(my_sum(Enum.map(list, fn x -> (x - avrg) * (x - avrg) end)) / elementCount)
  end
  # My implementation of the sum function
  defp my_sum([]), do: 0
  defp my_sum([head | tail]), do: head + my_sum(tail)
end
