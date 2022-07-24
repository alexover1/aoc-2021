defmodule Day6 do
  def parse_input(input) do
    String.split(input, ",")
    |> Enum.map(fn s ->
      {i, ""} = Integer.parse(s)
      i
    end)
    |> Enum.filter(fn e -> e != "" end)
    |> Enum.frequencies()
  end

  def next_day(school, 0), do: school

  def next_day(school, n) do
    Map.pop(school, 0)
    |> Kernel.then(fn {spawn, school} ->
      Enum.map(school, fn {k, v} -> {k - 1, v} end)
      |> Enum.into(%{})
      |> Map.merge(
        %{6 => spawn, 8 => spawn},
        fn _k, v1, v2 ->
          cond do
            v1 == nil && v2 == nil -> 0
            v1 != nil && v2 == nil -> v1
            v1 == nil && v2 != nil -> v2
            v1 != nil && v2 != nil -> v1 + v2
          end
        end
      )
    end)
    |> next_day(n - 1)
  end

  def part_one(input) do
    input
    |> parse_input
    |> next_day(80)
    |> Map.values()
    |> Enum.sum()
  end

  def part_two(input) do
    input
    |> parse_input
    |> next_day(256)
    |> Map.values()
    |> Enum.sum()
  end
end

case File.read("./input.txt") do
  {:ok, body} ->
    IO.puts "Part One: #{Day6.part_one(body)}"
    IO.puts "Part Two: #{Day6.part_two(body)}"

  {:error, reason} ->
    IO.puts(:stderr, reason)
end