defmodule Handle do
  @moduledoc """
  Handle module for list entries such as `items` and `emails`.
  The most used function and the `calculate/2` function.
  """

  @doc """
  Function calculates the total value of a list of items,
  divides the total amount according to the amount and past emails.

  ## Function parameters

    - items: list of maps contains information about the list item
    - emails: list of people who will be divided the total amount

  ## Additional Information

    - if the parameters passed are empty lists, the function returns an empty list

  ## Example empty lists

       iex> Handle.calculate([], [])
       []

  ## Example non-empty lists

      iex> Handle.calculate([%{name: "arroz", amount: 4, price: 598, type: "kg"}, %{name: "feijão", amount: 4, price: 799, type: "kg"}, %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"}], ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com", "teste4@gmail.com"])
      [
         %{email: "teste1@gmail.com", value: 56.86},
         %{email: "teste2@gmail.com", value: 56.86},
         %{email: "teste3@gmail.com", value: 56.86},
         %{email: "teste4@gmail.com", value: 56.86}
      ]
  """
  def calculate([], []), do: []

  @spec calculate(list(), list()) :: [map()]
  def calculate(itens, emails) do
    amount = itens |> Enum.map(fn item -> item.amount * item.price end) |> Enum.sum()
    people = emails |> Enum.count()

    split(amount, people, emails)
  end

  @doc """
  Function calculates apportionment of how much each person must pay.
  And it displays in a `map` with the email of each person and the amount of must be paid.

  ## Function parameters

    - value: total value of the list of items, the result of the sum of the quantity
            and the unique value of each item.
    - quantity: number of people / emails from the email list
    - emails: the email list

  ## Additional Information

    - function returns a `list` of` map`:
    ```Elixir
      [%{email: teste@email.com, value: 50.00}]
    ```

  ## Example

       iex> Handle.split(100, 3, ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com"])
       [
        %{email: "teste1@gmail.com", value: 0.33},
        %{email: "teste2@gmail.com", value: 0.33},
        %{email: "teste3@gmail.com", value: 0.34}
       ]
  """
  @spec split(number, number, list()) :: [map()]
  def split(value, quantity, emails) do
    cloven = value / quantity

    value = process(cloven)

    case value do
      {:float, cloven} ->
        list = Enum.map(emails, fn email -> %{email: email, value: cloven} end)

        key = Enum.count(list) - 1

        list
        |> List.update_at(key, fn pessoas ->
          %{email: pessoas.email, value: pessoas.value + 0.01}
        end)

      {:interge, cloven} ->
        Enum.map(emails, fn email -> %{email: email, value: cloven} end)
    end
  end

  @doc """
  Function processes the ratio value, checking if the obtained value is a fraction
  with infinite decimal or an integer.

  ## Function parameters

    - clove: value obtained by dividing the sum of items by number of people / email

  ## Additional Information

    - the function returns a {: interge, value} structure, if the result of the apportionment is an integer
    - or {: float, value}, if the result of the apportionment is a fraction with infinite decimal.

  ## Example

       iex> Handle.process(33.33333333333)
       {:float, 0.33}

       iex> Handle.process(500.0)
       {:interge, 5.0}
  """
  @spec process(float) :: {:float, float} | {:interge, float}
  def process(cloven) when is_float(cloven) do
    digits =
      cloven
      |> Float.to_string()
      |> String.split(".")
      |> List.last()
      |> String.length()

    if digits > 2 do
      cloven = cloven / 100

      cloven =
        cloven
        |> Float.round(2)

      {:float, cloven}
    else
      cloven = cloven / 100

      {:interge, cloven}
    end
  end
end
