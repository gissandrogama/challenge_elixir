defmodule ChallengeTest do
  use ExUnit.Case
  doctest Handle

  describe "calculate/2" do
    test "return empty list" do
      itens = []
      emails = []
      result = Handle.calculate(itens, emails)
      assert result == []
    end

    test "when an item of 1 real is divided for 3 people" do
      itens = [%{name: "chocolate stick", amount: 1, price: 1_00, type: "unity"}]
      emails = ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com"]
      result = Handle.calculate(itens, emails)

      assert result == [
               %{email: "teste1@gmail.com", value: 0.33},
               %{email: "teste2@gmail.com", value: 0.33},
               %{email: "teste3@gmail.com", value: 0.34}
             ]
    end

    test "several items for several people" do
      itens = [
        %{name: "contra file", amount: 3, price: 5000, type: "kg"},
        %{name: "leite liquido", amount: 4, price: 399, type: "litro"},
        %{name: "arroz", amount: 4, price: 598, type: "kg"},
        %{name: "feijão", amount: 4, price: 799, type: "kg"},
        %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"}
      ]

      emails = ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com", "teste4@gmail.com"]
      result = Handle.calculate(itens, emails)

      assert result == [
               %{email: "teste1@gmail.com", value: 98.35},
               %{email: "teste2@gmail.com", value: 98.35},
               %{email: "teste3@gmail.com", value: 98.35},
               %{email: "teste4@gmail.com", value: 98.35}
             ]
    end

    test "several items for one person" do
      itens = [
        %{name: "contra file", amount: 3, price: 5000, type: "kg"},
        %{name: "leite liquido", amount: 4, price: 399, type: "litro"},
        %{name: "arroz", amount: 4, price: 598, type: "kg"},
        %{name: "feijão", amount: 4, price: 799, type: "kg"},
        %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"},
        %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"}
      ]

      emails = ["teste1@gmail.com"]
      result = Handle.calculate(itens, emails)

      assert result == [%{email: "teste1@gmail.com", value: 564.96}]
    end
  end
end
