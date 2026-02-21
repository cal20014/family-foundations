# Family Foundations

This is an interactive educational application built with **Elixir** and **Phoenix LiveView**. It provides a digital flashcard experience designed to help children learn names, sounds, and descriptions of animals, shapes, and foods.

The project demonstrates core functional programming concepts in Elixir, including **recursion**, **pattern matching**, **guards**, and **state management** within a LiveView process. By leveraging the **Erlang VM (BEAM)**, the app is built for high concurrency and fault tolerance.

## Instructions for Build and Use

[Module 3 Demo](https://youtu.be/sznxjErD4oM)
[Module 2 Demo](https://youtu.be/hV1JFDelKR8)

### Environment Configuration:

1. Environment Variables: Create a .env file from your template. If using direnv, create a .envrc file containing "dotenv" and run "direnv allow" to automatically load your DATABASE_URL and SECRET_KEY_BASE.
2. Database Hosting: Ensure Docker is running to host a local PostgreSQL instance or configure your .env file with a Supabase connection string.

### Steps to build and run the software:

1. Install Dependencies: In the project directory, run "mix deps.get" to install Phoenix and Elixir dependencies, including the argon2 package for secure authentication.
2. Database Setup: Run "mix ecto.setup" to create the database, run migrations for users and discovery tables, and seed initial data.
3. Assets Setup: Run "mix assets.setup" to prepare Tailwind CSS and Esbuild.
4. Start Server: Launch the Phoenix server by running "iex -S mix phx.server".
5. Access the App: Open your web browser and navigate to http://localhost:4000.

### Instructions for using the software:

1. Authentication: Register using your email. The system uses Magic Link authentication. Visit http://localhost:4000/dev/mailbox in development to access the login link sent to your email.
2. Filter and Sort: Use the controls at the top to select a category (Animals, Shapes, or Colors) and choose between A-Z or Shuffle mode.
3. Interact: Look at the visual prompt, guess the answer, and click Show Answer to reveal the card details.
4. Navigate: Click Next Card to move through the deck and watch the progress bar fill up.
5. Finish: Reach the end of the deck to trigger the completion screen.

## Development Environment

To recreate the development environment, you need the following software and libraries:

- Elixir: ~> 1.19
- Erlang/OTP: Version 28+
- Phoenix Framework: ~> 1.8.3
- Web Server: Bandit ~> 1.5
- Database: PostgreSQL or Supabase
- Containerization: Docker
- Environment Management: direnv
- Security: Argon2 for password hashing
- UI Assets: Tailwind CSS ~> 0.3 and Heroicons v2.2.0

## Data Architecture and Logic

The application uses a specialized Ecto structure called Class Table Inheritance:

- Subject (Hub): The central table storing common fields like name and category.
- Animal/Color/Shape (Spokes): Specialized tables that share the primary key of the Subject.
- Passwordless Auth: A secure magic link flow that handles user sessions without requiring passwords by default.

## Useful Websites to Learn More

### Official Documentation

- Official Elixir Website: Language overview and philosophy.
- Elixir Introduction Guide: Foundation for functional syntax.
- Phoenix Framework Official Site: The modern web framework used for this project.
- Phoenix Overview and HexDocs: Technical documentation for the ecosystem.

### Educational Resources

- Thinking Elixir Podcast: Ecosystem updates and community news.
- Elixir Crash Course (Daniel Bergholz): Deep-dive video resource for functional basics.
- FreeCodeCamp and CodeSignal: Logic and algorithm practice.
- Tech School and The Course Shelf: Advanced backend learning paths.
- Elixir School: Lessons on pattern matching and recursion.

## Future Work

The following items are planned to improve and scale the application:

- [x] Database Migration: Implement PostgreSQL storage with successful migration to local and cloud (Supabase) instances.
- [x] Authentication and User Management: Implement secure magic link registration and password optionality.
- [ ] Dynamic Subject Forms: Create a single LiveView form that uses nested Ecto changesets to dynamically switch fields based on the selected category.
- [ ] Media Uploads: Integrate AWS S3 or Supabase Storage for custom image and audio uploads for each flashcard.
