# EctoAggregate

**Work in progress!**

This package provides JSON interface to aggregate data via Ecto queries.

General syntax is available at [API Manifest - Aggregating Lists](http://docs.apimanifest.apiary.io/#introduction/optional-features/aggregating-lists).

## Installation

The package can be installed as:

  1. Add `ecto_aggregate` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ecto_aggregate, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ecto_aggregate` is started before your application:

    ```elixir
    def application do
      [applications: [:ecto_aggregate]]
    end
    ```

## Docs

The docs can be found at [https://hexdocs.pm/ecto_aggregate](https://hexdocs.pm/ecto_aggregate)

