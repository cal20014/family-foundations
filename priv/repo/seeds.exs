# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FamilyFoundations.Repo.insert!(%FamilyFoundations.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FamilyFoundations.Repo
alias FamilyFoundations.Accounts.User
alias FamilyFoundations.Discovery.{Category, Subject, Animal, Color, Shape, MediaAsset}

# 1. Setup User
user_email = "parent@example.com"

user =
  Repo.get_by(User, email: user_email) ||
    Repo.insert!(%User{
      email: user_email,
      hashed_password: Argon2.hash_pwd_salt("password1234"),
      confirmed_at: DateTime.utc_now() |> DateTime.truncate(:second)
    })

# 2. Setup Categories
categories = ["Animals", "Colors", "Shapes"]

cat_map =
  for name <- categories, into: %{} do
    record =
      Repo.get_by(Category, name: name, user_id: user.id) ||
        Repo.insert!(%Category{name: name, description: "Category for #{name}", user_id: user.id})

    {name, record.id}
  end

IO.puts("Seeding 10 of each category...")

# 3. Seed 10 Animals
animals = [
  {"Lion", "Panthera leo"},
  {"Tiger", "Panthera tigris"},
  {"Elephant", "Loxodonta"},
  {"Giraffe", "Giraffa"},
  {"Zebra", "Equus quagga"},
  {"Panda", "Ailuropoda melanoleuca"},
  {"Kangaroo", "Macropus"},
  {"Wolf", "Canis lupus"},
  {"Eagle", "Haliaeetus leucocephalus"},
  {"Shark", "Carcharodon carcharias"}
]

Enum.each(animals, fn {name, sci} ->
  subject =
    Repo.insert!(%Subject{common_name: name, category_id: cat_map["Animals"], user_id: user.id})

  Repo.insert!(%Animal{
    subject_id: subject.id,
    scientific_name: sci,
    diet_type: Enum.random(["Herbivore", "Carnivore", "Omnivore"]),
    avg_weight_kg: :rand.uniform(500) / 1.0,
    avg_size_cm: :rand.uniform(300) / 1.0,
    user_id: user.id
  })
end)

# 4. Seed 10 Colors
colors = [
  {"Red", "#FF0000"},
  {"Blue", "#0000FF"},
  {"Green", "#00FF00"},
  {"Yellow", "#FFFF00"},
  {"Purple", "#800080"},
  {"Orange", "#FFA500"},
  {"Pink", "#FFC0CB"},
  {"Brown", "#A52A2A"},
  {"Black", "#000000"},
  {"White", "#FFFFFF"}
]

Enum.each(colors, fn {name, hex} ->
  subject =
    Repo.insert!(%Subject{common_name: name, category_id: cat_map["Colors"], user_id: user.id})

  Repo.insert!(%Color{
    subject_id: subject.id,
    hex_code: hex,
    rgb_value: "Generated during seed",
    user_id: user.id
  })
end)

# 5. Seed 10 Shapes
shapes = [
  "Circle",
  "Square",
  "Triangle",
  "Rectangle",
  "Pentagon",
  "Hexagon",
  "Octagon",
  "Star",
  "Oval",
  "Diamond"
]

Enum.each(shapes, fn name ->
  subject =
    Repo.insert!(%Subject{common_name: name, category_id: cat_map["Shapes"], user_id: user.id})

  Repo.insert!(%Shape{
    subject_id: subject.id,
    sides_count: Enum.random(1..10),
    is_2d: true,
    user_id: user.id
  })
end)

IO.puts("Finished seeding 30 total subjects!")
