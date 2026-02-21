defmodule FamilyFoundations.Discovery do
  @moduledoc """
  The Discovery context.
  """

  import Ecto.Query, warn: false
  alias FamilyFoundations.Repo

  alias FamilyFoundations.Discovery.Category
  alias FamilyFoundations.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any category changes.

  The broadcasted messages match the pattern:

    * {:created, %Category{}}
    * {:updated, %Category{}}
    * {:deleted, %Category{}}

  """
  def subscribe_categories(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(FamilyFoundations.PubSub, "user:#{key}:categories")
  end

  defp broadcast_category(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(FamilyFoundations.PubSub, "user:#{key}:categories", message)
  end

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories(scope)
      [%Category{}, ...]

  """
  def list_categories(%Scope{} = scope) do
    Repo.all_by(Category, user_id: scope.user.id)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(scope, 123)
      %Category{}

      iex> get_category!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(%Scope{} = scope, id) do
    Repo.get_by!(Category, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(scope, %{field: value})
      {:ok, %Category{}}

      iex> create_category(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(%Scope{} = scope, attrs) do
    with {:ok, category = %Category{}} <-
           %Category{}
           |> Category.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_category(scope, {:created, category})
      {:ok, category}
    end
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(scope, category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(scope, category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Scope{} = scope, %Category{} = category, attrs) do
    true = category.user_id == scope.user.id

    with {:ok, category = %Category{}} <-
           category
           |> Category.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_category(scope, {:updated, category})
      {:ok, category}
    end
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(scope, category)
      {:ok, %Category{}}

      iex> delete_category(scope, category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Scope{} = scope, %Category{} = category) do
    true = category.user_id == scope.user.id

    with {:ok, category = %Category{}} <-
           Repo.delete(category) do
      broadcast_category(scope, {:deleted, category})
      {:ok, category}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(scope, category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Scope{} = scope, %Category{} = category, attrs \\ %{}) do
    true = category.user_id == scope.user.id

    Category.changeset(category, attrs, scope)
  end

  alias FamilyFoundations.Discovery.Subject
  alias FamilyFoundations.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any subject changes.

  The broadcasted messages match the pattern:

    * {:created, %Subject{}}
    * {:updated, %Subject{}}
    * {:deleted, %Subject{}}

  """
  def subscribe_subjects(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(FamilyFoundations.PubSub, "user:#{key}:subjects")
  end

  defp broadcast_subject(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(FamilyFoundations.PubSub, "user:#{key}:subjects", message)
  end

  @doc """
  Returns the list of subjects.

  ## Examples

      iex> list_subjects(scope)
      [%Subject{}, ...]

  """
  def list_subjects(%Scope{} = scope) do
    Repo.all_by(Subject, user_id: scope.user.id)
  end

  @doc """
  Gets a single subject.

  Raises `Ecto.NoResultsError` if the Subject does not exist.

  ## Examples

      iex> get_subject!(scope, 123)
      %Subject{}

      iex> get_subject!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_subject!(%Scope{} = scope, id) do
    Repo.get_by!(Subject, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a subject.

  ## Examples

      iex> create_subject(scope, %{field: value})
      {:ok, %Subject{}}

      iex> create_subject(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subject(%Scope{} = scope, attrs) do
    with {:ok, subject = %Subject{}} <-
           %Subject{}
           |> Subject.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_subject(scope, {:created, subject})
      {:ok, subject}
    end
  end

  @doc """
  Updates a subject.

  ## Examples

      iex> update_subject(scope, subject, %{field: new_value})
      {:ok, %Subject{}}

      iex> update_subject(scope, subject, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subject(%Scope{} = scope, %Subject{} = subject, attrs) do
    true = subject.user_id == scope.user.id

    with {:ok, subject = %Subject{}} <-
           subject
           |> Subject.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_subject(scope, {:updated, subject})
      {:ok, subject}
    end
  end

  @doc """
  Deletes a subject.

  ## Examples

      iex> delete_subject(scope, subject)
      {:ok, %Subject{}}

      iex> delete_subject(scope, subject)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subject(%Scope{} = scope, %Subject{} = subject) do
    true = subject.user_id == scope.user.id

    with {:ok, subject = %Subject{}} <-
           Repo.delete(subject) do
      broadcast_subject(scope, {:deleted, subject})
      {:ok, subject}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subject changes.

  ## Examples

      iex> change_subject(scope, subject)
      %Ecto.Changeset{data: %Subject{}}

  """
  def change_subject(%Scope{} = scope, %Subject{} = subject, attrs \\ %{}) do
    true = subject.user_id == scope.user.id

    Subject.changeset(subject, attrs, scope)
  end

  alias FamilyFoundations.Discovery.Animal
  alias FamilyFoundations.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any animal changes.

  The broadcasted messages match the pattern:

    * {:created, %Animal{}}
    * {:updated, %Animal{}}
    * {:deleted, %Animal{}}

  """
  def subscribe_animals(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(FamilyFoundations.PubSub, "user:#{key}:animals")
  end

  defp broadcast_animal(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(FamilyFoundations.PubSub, "user:#{key}:animals", message)
  end

  @doc """
  Returns the list of animals.

  ## Examples

      iex> list_animals(scope)
      [%Animal{}, ...]

  """
  def list_animals(%Scope{} = scope) do
    Repo.all_by(Animal, user_id: scope.user.id)
  end

  @doc """
  Gets a single animal.

  Raises `Ecto.NoResultsError` if the Animal does not exist.

  ## Examples

      iex> get_animal!(scope, 123)
      %Animal{}

      iex> get_animal!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_animal!(%Scope{} = scope, id) do
    Repo.get_by!(Animal, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a animal.

  ## Examples

      iex> create_animal(scope, %{field: value})
      {:ok, %Animal{}}

      iex> create_animal(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_animal(%Scope{} = scope, attrs) do
    with {:ok, animal = %Animal{}} <-
           %Animal{}
           |> Animal.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_animal(scope, {:created, animal})
      {:ok, animal}
    end
  end

  @doc """
  Updates a animal.

  ## Examples

      iex> update_animal(scope, animal, %{field: new_value})
      {:ok, %Animal{}}

      iex> update_animal(scope, animal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_animal(%Scope{} = scope, %Animal{} = animal, attrs) do
    true = animal.user_id == scope.user.id

    with {:ok, animal = %Animal{}} <-
           animal
           |> Animal.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_animal(scope, {:updated, animal})
      {:ok, animal}
    end
  end

  @doc """
  Deletes a animal.

  ## Examples

      iex> delete_animal(scope, animal)
      {:ok, %Animal{}}

      iex> delete_animal(scope, animal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_animal(%Scope{} = scope, %Animal{} = animal) do
    true = animal.user_id == scope.user.id

    with {:ok, animal = %Animal{}} <-
           Repo.delete(animal) do
      broadcast_animal(scope, {:deleted, animal})
      {:ok, animal}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking animal changes.

  ## Examples

      iex> change_animal(scope, animal)
      %Ecto.Changeset{data: %Animal{}}

  """
  def change_animal(%Scope{} = scope, %Animal{} = animal, attrs \\ %{}) do
    true = animal.user_id == scope.user.id

    Animal.changeset(animal, attrs, scope)
  end

  alias FamilyFoundations.Discovery.Color
  alias FamilyFoundations.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any color changes.

  The broadcasted messages match the pattern:

    * {:created, %Color{}}
    * {:updated, %Color{}}
    * {:deleted, %Color{}}

  """
  def subscribe_colors(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(FamilyFoundations.PubSub, "user:#{key}:colors")
  end

  defp broadcast_color(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(FamilyFoundations.PubSub, "user:#{key}:colors", message)
  end

  @doc """
  Returns the list of colors.

  ## Examples

      iex> list_colors(scope)
      [%Color{}, ...]

  """
  def list_colors(%Scope{} = scope) do
    Repo.all_by(Color, user_id: scope.user.id)
  end

  @doc """
  Gets a single color.

  Raises `Ecto.NoResultsError` if the Color does not exist.

  ## Examples

      iex> get_color!(scope, 123)
      %Color{}

      iex> get_color!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_color!(%Scope{} = scope, id) do
    Repo.get_by!(Color, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a color.

  ## Examples

      iex> create_color(scope, %{field: value})
      {:ok, %Color{}}

      iex> create_color(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_color(%Scope{} = scope, attrs) do
    with {:ok, color = %Color{}} <-
           %Color{}
           |> Color.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_color(scope, {:created, color})
      {:ok, color}
    end
  end

  @doc """
  Updates a color.

  ## Examples

      iex> update_color(scope, color, %{field: new_value})
      {:ok, %Color{}}

      iex> update_color(scope, color, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_color(%Scope{} = scope, %Color{} = color, attrs) do
    true = color.user_id == scope.user.id

    with {:ok, color = %Color{}} <-
           color
           |> Color.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_color(scope, {:updated, color})
      {:ok, color}
    end
  end

  @doc """
  Deletes a color.

  ## Examples

      iex> delete_color(scope, color)
      {:ok, %Color{}}

      iex> delete_color(scope, color)
      {:error, %Ecto.Changeset{}}

  """
  def delete_color(%Scope{} = scope, %Color{} = color) do
    true = color.user_id == scope.user.id

    with {:ok, color = %Color{}} <-
           Repo.delete(color) do
      broadcast_color(scope, {:deleted, color})
      {:ok, color}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking color changes.

  ## Examples

      iex> change_color(scope, color)
      %Ecto.Changeset{data: %Color{}}

  """
  def change_color(%Scope{} = scope, %Color{} = color, attrs \\ %{}) do
    true = color.user_id == scope.user.id

    Color.changeset(color, attrs, scope)
  end

  alias FamilyFoundations.Discovery.Shape
  alias FamilyFoundations.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any shape changes.

  The broadcasted messages match the pattern:

    * {:created, %Shape{}}
    * {:updated, %Shape{}}
    * {:deleted, %Shape{}}

  """
  def subscribe_shapes(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(FamilyFoundations.PubSub, "user:#{key}:shapes")
  end

  defp broadcast_shape(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(FamilyFoundations.PubSub, "user:#{key}:shapes", message)
  end

  @doc """
  Returns the list of shapes.

  ## Examples

      iex> list_shapes(scope)
      [%Shape{}, ...]

  """
  def list_shapes(%Scope{} = scope) do
    Repo.all_by(Shape, user_id: scope.user.id)
  end

  @doc """
  Gets a single shape.

  Raises `Ecto.NoResultsError` if the Shape does not exist.

  ## Examples

      iex> get_shape!(scope, 123)
      %Shape{}

      iex> get_shape!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_shape!(%Scope{} = scope, id) do
    Repo.get_by!(Shape, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a shape.

  ## Examples

      iex> create_shape(scope, %{field: value})
      {:ok, %Shape{}}

      iex> create_shape(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shape(%Scope{} = scope, attrs) do
    with {:ok, shape = %Shape{}} <-
           %Shape{}
           |> Shape.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_shape(scope, {:created, shape})
      {:ok, shape}
    end
  end

  @doc """
  Updates a shape.

  ## Examples

      iex> update_shape(scope, shape, %{field: new_value})
      {:ok, %Shape{}}

      iex> update_shape(scope, shape, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shape(%Scope{} = scope, %Shape{} = shape, attrs) do
    true = shape.user_id == scope.user.id

    with {:ok, shape = %Shape{}} <-
           shape
           |> Shape.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_shape(scope, {:updated, shape})
      {:ok, shape}
    end
  end

  @doc """
  Deletes a shape.

  ## Examples

      iex> delete_shape(scope, shape)
      {:ok, %Shape{}}

      iex> delete_shape(scope, shape)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shape(%Scope{} = scope, %Shape{} = shape) do
    true = shape.user_id == scope.user.id

    with {:ok, shape = %Shape{}} <-
           Repo.delete(shape) do
      broadcast_shape(scope, {:deleted, shape})
      {:ok, shape}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shape changes.

  ## Examples

      iex> change_shape(scope, shape)
      %Ecto.Changeset{data: %Shape{}}

  """
  def change_shape(%Scope{} = scope, %Shape{} = shape, attrs \\ %{}) do
    true = shape.user_id == scope.user.id

    Shape.changeset(shape, attrs, scope)
  end

  alias FamilyFoundations.Discovery.MediaAsset
  alias FamilyFoundations.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any media_asset changes.

  The broadcasted messages match the pattern:

    * {:created, %MediaAsset{}}
    * {:updated, %MediaAsset{}}
    * {:deleted, %MediaAsset{}}

  """
  def subscribe_media(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(FamilyFoundations.PubSub, "user:#{key}:media")
  end

  defp broadcast_media_asset(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(FamilyFoundations.PubSub, "user:#{key}:media", message)
  end

  @doc """
  Returns the list of media.

  ## Examples

      iex> list_media(scope)
      [%MediaAsset{}, ...]

  """
  def list_media(%Scope{} = scope) do
    Repo.all_by(MediaAsset, user_id: scope.user.id)
  end

  @doc """
  Gets a single media_asset.

  Raises `Ecto.NoResultsError` if the Media asset does not exist.

  ## Examples

      iex> get_media_asset!(scope, 123)
      %MediaAsset{}

      iex> get_media_asset!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_media_asset!(%Scope{} = scope, id) do
    Repo.get_by!(MediaAsset, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a media_asset.

  ## Examples

      iex> create_media_asset(scope, %{field: value})
      {:ok, %MediaAsset{}}

      iex> create_media_asset(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_media_asset(%Scope{} = scope, attrs) do
    with {:ok, media_asset = %MediaAsset{}} <-
           %MediaAsset{}
           |> MediaAsset.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_media_asset(scope, {:created, media_asset})
      {:ok, media_asset}
    end
  end

  @doc """
  Updates a media_asset.

  ## Examples

      iex> update_media_asset(scope, media_asset, %{field: new_value})
      {:ok, %MediaAsset{}}

      iex> update_media_asset(scope, media_asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_media_asset(%Scope{} = scope, %MediaAsset{} = media_asset, attrs) do
    true = media_asset.user_id == scope.user.id

    with {:ok, media_asset = %MediaAsset{}} <-
           media_asset
           |> MediaAsset.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_media_asset(scope, {:updated, media_asset})
      {:ok, media_asset}
    end
  end

  @doc """
  Deletes a media_asset.

  ## Examples

      iex> delete_media_asset(scope, media_asset)
      {:ok, %MediaAsset{}}

      iex> delete_media_asset(scope, media_asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_media_asset(%Scope{} = scope, %MediaAsset{} = media_asset) do
    true = media_asset.user_id == scope.user.id

    with {:ok, media_asset = %MediaAsset{}} <-
           Repo.delete(media_asset) do
      broadcast_media_asset(scope, {:deleted, media_asset})
      {:ok, media_asset}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking media_asset changes.

  ## Examples

      iex> change_media_asset(scope, media_asset)
      %Ecto.Changeset{data: %MediaAsset{}}

  """
  def change_media_asset(%Scope{} = scope, %MediaAsset{} = media_asset, attrs \\ %{}) do
    true = media_asset.user_id == scope.user.id

    MediaAsset.changeset(media_asset, attrs, scope)
  end
end
