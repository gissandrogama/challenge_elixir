defmodule Handle do
  @moduledoc """
  handle module
  """

  def calculate([], []), do: []
  @spec calculate(List.t(), List.t()) :: [Tuple]
  def calculate(itens, emails) do
    amount = itens |> Enum.map(fn item -> item.amount * item.price end) |> Enum.sum()
    people = emails |> Enum.count()

    split(amount, people, emails)
  end

  def split(value, quantity, emails) do
    cloven = value / quantity

    list = Enum.map(emails, &{&1, process(cloven)})

    key = Enum.count(list) - 1

    list
    |> List.update_at(key, fn {email, value} -> {email, Float.ceil(value, 2) } end)
  end

  def process(cloven) when is_float(cloven) do
    digits =
      cloven
      |> Float.to_string()
      |> String.split(".")
      |> List.last()
      |> String.length()

    cond do
      digits > 2 ->
        cloven = cloven / 100

        cloven
        |> Float.round(2)

      true ->
        cloven = cloven / 100

        cloven
    end
  end
end
