use Mix.Config

case Mix.env() do
  :test_alternative_map ->
    config :configparser,
      map_implementation: OrderedMap

  _ ->
    config :configparser,
      map_implementation: Map
end
