defmodule Hw.CSVTest do
  use ExUnit.Case
  alias Hw.CSVFiles
  # doctest Hw.CSVFiles

  test "convert csv file" do
    assert CSVFiles.main("../data/students_mex.csv", "../data/students_out.csv") ==
      :ok
  end
end
