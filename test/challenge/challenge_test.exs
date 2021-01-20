defmodule ChallengeTest do
  use ExUnit.Case

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
               {"teste1@gmail.com", 0.33},
               {"teste2@gmail.com", 0.33},
               {"teste3@gmail.com", 0.34}
             ]
    end

    test "when there are different items for different people" do
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
               {"teste1@gmail.com", 9835.0},
               {"teste2@gmail.com", 9835.0},
               {"teste3@gmail.com", 9835.0},
               {"teste4@gmail.com", 9835.0}
             ]
    end
  end
end
