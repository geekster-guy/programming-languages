# THIS IS WHERE YOU SHOUD WRITE YOUR FUNCTIONS
#
# Remember to add your name

defmodule Hw.Lists do


  # def swapper([], :_a, :_b), do: 0

  # def swapper(list, :first_element, :second_element) when hd(list) == :first_element, do: [:second_element | swapper(tl(list), :first_element, :second_element)]
  # def swapper(list, :first_element, :second_element) when hd(list) == :second_element, do: [:first_element | swapper(tl(list), :first_element, :second_element)]
  # def swapper(list, :first_element, :second_element), do: [hd(list) | swapper(tl(list), :first_element, :second_element)]

  # def swapper(_, _, _), do: []
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

  # # def invert_pairs(_), do: []

  def invert_tuple(tuple) do
    swap = ([&(tl/1)|&(hd/1)])
    # list = Tuple.to_list(tuple)
    tuple
    |> Tuple.to_list()
    |> swap.(&1)
    # |> [head | tail] = &(&1)
    # |> List.to_tuple()
  end

  # def invert_pairs(list) do
  #   cond do
  #     list == nil -> list
  #     [head | tail] = [hd(hd(list)) | tl(hd(list))]
  #     [tl(list) | (swapper(hd(list), head, tail))]
  #     # invert_elements(hd(list), [])
  #   end
  #     # cond do
  #       #   list == [] -> list
  #       #   true -> [invert_elements(hd(list), []) | invert_pairs(tl(list))]
  #       # end
  # end

  # defp invert_elements(list, acum) do
  #   cond do
  #     list == [] -> acum
  #     true -> invert_elements(tl(list), ([hd(list) | acum]))
  #   end
  # end

  # def deep_reverse(_), do: []

  def mean(list), do: average(list, 0, 0)

  # If the list is empty, return 0 (base case)
  def average([], 0, 0), do: 0
  def average([], count, sum), do: (sum / count)
  def average([head | tail], count, sum) do
    average(tail, (count + 1), (sum + head))
  end

  # def std_dev(_), do: 0
end
