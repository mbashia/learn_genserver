defmodule LearnGenserver.Repo do
  use Ecto.Repo,
    otp_app: :learn_genserver,
    adapter: Ecto.Adapters.Postgres
end
