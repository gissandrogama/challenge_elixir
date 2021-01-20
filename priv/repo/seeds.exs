# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Challenge.Repo.insert!(%Challenge.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
@buy [
  %{name: "contra file", amount: 3, price: 5000, type: "kg"},
  %{name: "leite liquido", amount: 4, price: 399, type: "litro"},
  %{name: "arroz", amount: 4, price: 598, type: "kg"},
  %{name: "feijão", amount: 4, price: 799, type: "kg"},
  %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"}
]
@email ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com", "teste4@gmail.com"]
