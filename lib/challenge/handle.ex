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

    list = Enum.map(emails, &{&1, process(cloven)})

    key = Enum.count(list) - 1

    list
    |> List.update_at(key, fn {email, value} -> {email, Float.ceil(value, 2)} end)
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
