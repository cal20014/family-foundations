defmodule FamilyFoundations.Repo do
  use Ecto.Repo,
    otp_app: :family_foundations,
    adapter: Ecto.Adapters.Postgres
end
