defmodule EctoAggregate do
  @moduledoc """
  WIP.
  """
  import Ecto.Query

  @strategies ["count", "sum", "distinct", "max", "min", "avg"]
  @ticks ["hour", "day", "month", "year"]

  def aggregate(%Ecto.Query{} = queryable, expr) do
    expr
    |> decode()
    |> reduce_expr(queryable)
  end

  defp decode(expr) do
    with {:ok, json} <- Base.decode64(expr),
         {:ok, map} <- Poison.decode(json),
     do: map
  end

  defp reduce_expr([], query),
    do: query
  defp reduce_expr([%{"field" => field, "strategy" => strategy, "tick" => tick} = expr | t], query),
    do: reduce_expr(t, apply_expr(query, get_name!(expr), get_tick!(tick), strategy, field))
  defp reduce_expr(exprs, _query),
    do: raise ArgumentError, "Unsupported aggregation query structure, got #{inspect exprs}"

  defp get_name!(%{"name" => name}),
    do: name
  defp get_name!(%{"field" => field, "strategy" => strategy}),
    do: field <> "_" <> strategy

  defp get_tick!(tick) when tick in @ticks,
    do: String.to_atom(tick)
  defp get_tick!(tick),
    do: raise ArgumentError, "Unsupported tick value #{inspect tick}"

  defp get_strategy!(strategy) when strategy in @strategies,
    do: String.to_atom(strategy)
  defp get_strategy!(strategy),
    do: raise ArgumentError, "Unsupported strategy value #{inspect strategy}"

  defp apply_expr(query, name, tick, :count, field) do
    query
    |> select([s], s.inserted_at.day, count(s.id))
    |> group_by([s], s.inserted_at.day)
  end

  defp apply_expr(query, name, tick, :sum, field) do
    query
  end

  defp apply_expr(query, name, tick, :distinct, field) do
    query
  end

  defp apply_expr(query, name, tick, :max, field) do
    query
  end

  defp apply_expr(query, name, tick, :min, field) do
    query
  end

  defp apply_expr(query, name, tick, :avg, field) do
    query
  end
end


      #     SELECT days.day,
      #            count(case when DATE(inserted_at) = day then 1 end) as created,
      #            count(case when status = 'closed' and DATE(updated_at) = day then 1 end) as closed,
      #            count(case when status != 'closed' and DATE(inserted_at) <= day then 1 end) as total
      #       FROM declarations
      # RIGHT JOIN (
      #              SELECT date_trunc('day', series)::date AS day
      #              FROM generate_series('#{start_date}'::timestamp, '#{end_date}'::timestamp, '1 day'::interval) series
      #            ) days ON
      #                      doctor_id = '#{get_change(changeset, :doctor_id)}' AND
      #                      msp_id = '#{get_change(changeset, :msp_id)}' AND
      #                      inserted_at::date BETWEEN DATE('#{start_date}') AND DATE('#{end_date}')
      #   GROUP BY days.day
      #   ORDER BY days.day;
