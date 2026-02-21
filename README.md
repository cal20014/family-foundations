# Family Foundations

This is an interactive educational application built with **Elixir** and **Phoenix LiveView**. It provides a digital flashcard experience designed to help children learn names, sounds, and descriptions of animals, shapes, and foods.

The project demonstrates core functional programming concepts in Elixir, including **recursion**, **pattern matching**, **guards**, and **state management** within a LiveView process. By leveraging the **Erlang VM (BEAM)**, the app is built for high concurrency and fault tolerance.

## Instructions for Build and Use

[Software Demo](https://youtu.be/hV1JFDelKR8)

### Steps to build and run the software:

1. **Install Dependencies:** In the project directory, run `mix deps.get` to install the Phoenix and Elixir dependencies.
2. **Database Setup:** Ensure PostgreSQL is running and run `mix ecto.setup` to create and migrate your database.
3. **Assets Setup:** Run `mix assets.setup` to prepare Tailwind CSS and Esbuild.
4. **Start Server:** Launch the Phoenix server (powered by Bandit) by running `mix phx.server`.
5. **Access the App:** Open your web browser and navigate to `http://localhost:4000`.

### Instructions for using the software:

1. **Filter & Sort:** Use the controls at the top to select a category (Animals, Shapes, or Food) and choose between "A-Z" or "Shuffle" mode.
2. **Interact:** Look at the visual prompt, guess the answer, and click "Show Answer" to reveal the card details.
3. **Navigate:** Click "Next Card" to move through the deck and watch the progress bar fill up.
4. **Finish:** Reach the end of the deck to trigger the completion screen!

## Development Environment

To recreate the development environment, you need the following software and libraries:

- **Elixir**: ~> 1.19
- **Erlang/OTP**: Version 28+
- **Phoenix Framework**: ~> 1.8.3
- **Web Server**: Bandit ~> 1.5
- **Database**: PostgreSQL / Supabase
- **UI/Assets**: Tailwind CSS ~> 0.3 and Heroicons v2.2.0

## Useful Websites to Learn More

### Official Documentation

- [Official Elixir Website](https://elixir-lang.org/) - Language overview and philosophy.
- [Elixir Introduction Guide](https://hexdocs.pm/elixir/introduction.html) - Foundation for functional syntax.
- [Phoenix Framework Official Site](https://www.phoenixframework.org/) - The modern web framework used for this project.
- [Phoenix Overview & HexDocs](https://hexdocs.pm/phoenix/overview.html) - Technical documentation for the ecosystem.

### Educational Resources

- [Thinking Elixir Podcast](https://podcast.thinkingelixir.com/) - Ecosystem updates and community news.
- [Elixir Crash Course (Daniel Bergholz)](https://www.youtube.com/watch?v=Q0Z1jqv6LW0&list=PLbV6TI03ZWYVQEC_Txq_cV0Uy_s16b0d3) - Deep-dive video resource for functional basics.
- [FreeCodeCamp](https://www.freecodecamp.org/) & [CodeSignal](https://codesignal.com/) - Logic and algorithm practice.
- [Tech School](https://techschool.dev/en) & [The Course Shelf](https://thecourseshelf.com/courses) - Advanced backend learning paths.
- [Elixir School](https://elixirschool.com/en/) - Lessons on pattern matching and recursion.

## Future Work

The following items are planned to improve and scale the application:

- [ ] **Database Migration:** Implement local PostgreSQL storage before migrating the database to **Supabase** for cloud-based scalability.
- [ ] **Authentication & User Management:** Add secure user registration and login to allow parents to manage progress and custom decks.
- [ ] **TDD Implementation:** Adopt a Test-Driven Development (TDD) approach using `Mox` and `ExMachina` to ensure 100% test coverage for new features.
- [ ] **Full-Scale Implementation:** Expand the existing LiveView demo into a full-scale application with expanded categories and interactive progress tracking.

# familyFoundations
# familyFoundations
# family-foundations
# family-foundations
