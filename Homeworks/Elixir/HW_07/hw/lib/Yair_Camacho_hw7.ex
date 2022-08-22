# Second elixir homework
# Working with files in elixir
#
# Yair Camacho
# 22/08/2022

defmodule Hw.CSVFiles do
  @moduledoc """
  Takes a list of students grades in mexican format and converts it
  into USA format.
  """

  @doc """
  Takes a file with students grades in mexican format and returns another file
  with the same student information but with a format that is more useful for
  the USA system.

  ## Parameters
    - inputFile: Path where is located the file to be read
    - outputFile: Path where the file with the processed data will be stored

  ## Examples
    iex> Hw.CSVFiles.main("../data/students_mex.csv", "../data/students_out.csv")
    :ok
  """
  def main(inputFile, outputFile) do
    # Reading the file
    data = read_contents(inputFile)
    # Trasforming the data
    list = process_data(data)
    # Adding the header to the new file
    processedData = [["Index","Name","Email","Graduation","Grade"] | list]
    # Creating the new file
    store_csv(processedData,outputFile)
  end

  # Fuction that reads the initial file
  defp read_contents(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&(String.split(&1, ",")))
  end

  # Converting the data
  defp process_data(data) do
    data
    |> tl()
    |> Enum.map(&convertRow(&1))
  end

  # Formating the rows
  defp convertRow(row) do
    [index, fullName, id, graduationStr, gradeStr] = row
    name = formatName(fullName)
    email = "#{id}@tec.mx"
    graduation = formatDate(graduationStr)
    grade = getGrade(String.to_integer(gradeStr))
    [index,name,email,graduation,grade]
  end

  # Strip the full name to first name and first surname
  defp formatName(name) do
    temp = String.split(name, " ")
    "#{Enum.at(temp, 0)} #{Enum.at(temp, 1)}"
  end

  # Changing the date format
  defp formatDate(date) do
    temp = String.split(date, "/")
    "#{Enum.at(temp, 1)}/#{Enum.at(temp, 0)}/#{Enum.at(temp, 2)}"
  end

  # Transforming the grades format
  defp getGrade(number) do
    # Mapping grades numbers to letters
    cond do
      number >= 93 -> "A"
      number >= 90 -> "A-"
      number >= 87 -> "B+"
      number >= 83 -> "B"
      number >= 80 -> "B-"
      number >= 77 -> "C+"
      number >= 73 -> "C"
      number >= 70 -> "C-"
      number >= 67 -> "D+"
      number >= 64 -> "D"
      number < 64 -> "E"
    end
  end

  # Function that creates the new cvs file
  defp store_csv(data, filename) do
    cvs = data
      |> Enum.map(&Enum.join(&1, ","))
      |> Enum.join("\n")
    File.write(filename,cvs)
  end
end
