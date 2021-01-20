defmodule Handle do
  @moduledoc """
  handle module
  """
  @buy [
    %{name: "contra file", amount: 3, price: 5000, type: "kg"},
    %{name: "leite liquido", amount: 4, price: 399, type: "litro"},
    %{name: "arroz", amount: 4, price: 598, type: "kg"},
    %{name: "feijão", amount: 4, price: 799, type: "kg"},
    %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"}
  ]
  @email ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com"]
  def caculate do
    amount = @buy |> Enum.map(fn item -> item.amount * item.price end) |> Enum.sum()
    people = @email |> Enum.count()

    split(amount, people)
  end

  def split(value, quantity) do
    cloven = value / quantity

    list = Enum.map(@email, &{&1, process(cloven)})

    key = Enum.count(list) - 1

    list
    |> List.update_at(key, fn {email, value} -> {email, value + 0.01} end)
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
        cloven
        |> Float.round(2)
    end
  end
end
