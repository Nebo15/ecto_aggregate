use Mix.Releases.Config,
  default_release: :default,
  default_environment: :default

cookie = :sha256
|> :crypto.hash(System.get_env("ERLANG_COOKIE") || "9YkfFZWF7NicnQHCBg3QNght6WycpP1x4RyPRqgSxD5g6eKyu45XWOdMN3M7Elnq")
|> Base.encode64

environment :default do
  set pre_start_hook: "bin/hooks/pre-start.sh"
  set dev_mode: false
  set include_erts: false
  set include_src: false
  set cookie: cookie
end

release :ecto_aggregate do
  set version: current_version(:ecto_aggregate)
  set applications: [
    ecto_aggregate: :permanent
  ]
end
