defmodule Handle do
  @moduledoc """
    Modulo de Handle para cadastros de listas como `@itens` e `@emails`

    A função mais ultilizada e a função `calculate/2`
  """

  @doc """
   Função calcula o valor total de uma lista de itens,
   divide o valor total conforme a quantidade e emails passados

   ## Parametros da função

   - itens: lista de maps contem informação de da item da lista
   - emails: lista de pessoas que será dividido o valor total

   ## Informações adicionais

   - caso os parametros forem passados lsitas vazias-

   ## Exemplo

       iex> Handle.calculate([], [])
       []
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
