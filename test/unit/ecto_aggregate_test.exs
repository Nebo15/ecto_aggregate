defmodule EctoAggregateTest do
  use ExUnit.Case
  doctest EctoAggregate

  test "parses JSON expression" do
    q = "{predicates:[{'name': 'accounts_count','strategy': 'count','field': 'id'}, " <>
        "{'name': 'accounts_liquidity', 'strategy': 'sum', 'field': 'balance'}" <>
        "]}"

    query =
      q
      |> Poison.encode!()
      |> Base.encode64()
      |> EctoAggregate.

    assert 1 + 1 == 2
  end
end
