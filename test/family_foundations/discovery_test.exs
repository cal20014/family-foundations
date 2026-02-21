defmodule FamilyFoundations.DiscoveryTest do
  use FamilyFoundations.DataCase

  alias FamilyFoundations.Discovery

  describe "categories" do
    alias FamilyFoundations.Discovery.Category

    import FamilyFoundations.AccountsFixtures, only: [user_scope_fixture: 0]
    import FamilyFoundations.DiscoveryFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_categories/1 returns all scoped categories" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      category = category_fixture(scope)
      other_category = category_fixture(other_scope)
      assert Discovery.list_categories(scope) == [category]
      assert Discovery.list_categories(other_scope) == [other_category]
    end

    test "get_category!/2 returns the category with given id" do
      scope = user_scope_fixture()
      category = category_fixture(scope)
      other_scope = user_scope_fixture()
      assert Discovery.get_category!(scope, category.id) == category
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_category!(other_scope, category.id) end
    end

    test "create_category/2 with valid data creates a category" do
      valid_attrs = %{name: "some name", description: "some description"}
      scope = user_scope_fixture()

      assert {:ok, %Category{} = category} = Discovery.create_category(scope, valid_attrs)
      assert category.name == "some name"
      assert category.description == "some description"
      assert category.user_id == scope.user.id
    end

    test "create_category/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Discovery.create_category(scope, @invalid_attrs)
    end

    test "update_category/3 with valid data updates the category" do
      scope = user_scope_fixture()
      category = category_fixture(scope)
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Category{} = category} = Discovery.update_category(scope, category, update_attrs)
      assert category.name == "some updated name"
      assert category.description == "some updated description"
    end

    test "update_category/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      category = category_fixture(scope)

      assert_raise MatchError, fn ->
        Discovery.update_category(other_scope, category, %{})
      end
    end

    test "update_category/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      category = category_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Discovery.update_category(scope, category, @invalid_attrs)
      assert category == Discovery.get_category!(scope, category.id)
    end

    test "delete_category/2 deletes the category" do
      scope = user_scope_fixture()
      category = category_fixture(scope)
      assert {:ok, %Category{}} = Discovery.delete_category(scope, category)
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_category!(scope, category.id) end
    end

    test "delete_category/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      category = category_fixture(scope)
      assert_raise MatchError, fn -> Discovery.delete_category(other_scope, category) end
    end

    test "change_category/2 returns a category changeset" do
      scope = user_scope_fixture()
      category = category_fixture(scope)
      assert %Ecto.Changeset{} = Discovery.change_category(scope, category)
    end
  end

  describe "subjects" do
    alias FamilyFoundations.Discovery.Subject

    import FamilyFoundations.AccountsFixtures, only: [user_scope_fixture: 0]
    import FamilyFoundations.DiscoveryFixtures

    @invalid_attrs %{common_name: nil}

    test "list_subjects/1 returns all scoped subjects" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      subject = subject_fixture(scope)
      other_subject = subject_fixture(other_scope)
      assert Discovery.list_subjects(scope) == [subject]
      assert Discovery.list_subjects(other_scope) == [other_subject]
    end

    test "get_subject!/2 returns the subject with given id" do
      scope = user_scope_fixture()
      subject = subject_fixture(scope)
      other_scope = user_scope_fixture()
      assert Discovery.get_subject!(scope, subject.id) == subject
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_subject!(other_scope, subject.id) end
    end

    test "create_subject/2 with valid data creates a subject" do
      valid_attrs = %{common_name: "some common_name"}
      scope = user_scope_fixture()

      assert {:ok, %Subject{} = subject} = Discovery.create_subject(scope, valid_attrs)
      assert subject.common_name == "some common_name"
      assert subject.user_id == scope.user.id
    end

    test "create_subject/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Discovery.create_subject(scope, @invalid_attrs)
    end

    test "update_subject/3 with valid data updates the subject" do
      scope = user_scope_fixture()
      subject = subject_fixture(scope)
      update_attrs = %{common_name: "some updated common_name"}

      assert {:ok, %Subject{} = subject} = Discovery.update_subject(scope, subject, update_attrs)
      assert subject.common_name == "some updated common_name"
    end

    test "update_subject/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      subject = subject_fixture(scope)

      assert_raise MatchError, fn ->
        Discovery.update_subject(other_scope, subject, %{})
      end
    end

    test "update_subject/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      subject = subject_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Discovery.update_subject(scope, subject, @invalid_attrs)
      assert subject == Discovery.get_subject!(scope, subject.id)
    end

    test "delete_subject/2 deletes the subject" do
      scope = user_scope_fixture()
      subject = subject_fixture(scope)
      assert {:ok, %Subject{}} = Discovery.delete_subject(scope, subject)
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_subject!(scope, subject.id) end
    end

    test "delete_subject/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      subject = subject_fixture(scope)
      assert_raise MatchError, fn -> Discovery.delete_subject(other_scope, subject) end
    end

    test "change_subject/2 returns a subject changeset" do
      scope = user_scope_fixture()
      subject = subject_fixture(scope)
      assert %Ecto.Changeset{} = Discovery.change_subject(scope, subject)
    end
  end

  describe "animals" do
    alias FamilyFoundations.Discovery.Animal

    import FamilyFoundations.AccountsFixtures, only: [user_scope_fixture: 0]
    import FamilyFoundations.DiscoveryFixtures

    @invalid_attrs %{scientific_name: nil, diet_type: nil, avg_weight_kg: nil, avg_size_cm: nil}

    test "list_animals/1 returns all scoped animals" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      animal = animal_fixture(scope)
      other_animal = animal_fixture(other_scope)
      assert Discovery.list_animals(scope) == [animal]
      assert Discovery.list_animals(other_scope) == [other_animal]
    end

    test "get_animal!/2 returns the animal with given id" do
      scope = user_scope_fixture()
      animal = animal_fixture(scope)
      other_scope = user_scope_fixture()
      assert Discovery.get_animal!(scope, animal.id) == animal
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_animal!(other_scope, animal.id) end
    end

    test "create_animal/2 with valid data creates a animal" do
      valid_attrs = %{scientific_name: "some scientific_name", diet_type: "some diet_type", avg_weight_kg: 120.5, avg_size_cm: 120.5}
      scope = user_scope_fixture()

      assert {:ok, %Animal{} = animal} = Discovery.create_animal(scope, valid_attrs)
      assert animal.scientific_name == "some scientific_name"
      assert animal.diet_type == "some diet_type"
      assert animal.avg_weight_kg == 120.5
      assert animal.avg_size_cm == 120.5
      assert animal.user_id == scope.user.id
    end

    test "create_animal/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Discovery.create_animal(scope, @invalid_attrs)
    end

    test "update_animal/3 with valid data updates the animal" do
      scope = user_scope_fixture()
      animal = animal_fixture(scope)
      update_attrs = %{scientific_name: "some updated scientific_name", diet_type: "some updated diet_type", avg_weight_kg: 456.7, avg_size_cm: 456.7}

      assert {:ok, %Animal{} = animal} = Discovery.update_animal(scope, animal, update_attrs)
      assert animal.scientific_name == "some updated scientific_name"
      assert animal.diet_type == "some updated diet_type"
      assert animal.avg_weight_kg == 456.7
      assert animal.avg_size_cm == 456.7
    end

    test "update_animal/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      animal = animal_fixture(scope)

      assert_raise MatchError, fn ->
        Discovery.update_animal(other_scope, animal, %{})
      end
    end

    test "update_animal/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      animal = animal_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Discovery.update_animal(scope, animal, @invalid_attrs)
      assert animal == Discovery.get_animal!(scope, animal.id)
    end

    test "delete_animal/2 deletes the animal" do
      scope = user_scope_fixture()
      animal = animal_fixture(scope)
      assert {:ok, %Animal{}} = Discovery.delete_animal(scope, animal)
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_animal!(scope, animal.id) end
    end

    test "delete_animal/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      animal = animal_fixture(scope)
      assert_raise MatchError, fn -> Discovery.delete_animal(other_scope, animal) end
    end

    test "change_animal/2 returns a animal changeset" do
      scope = user_scope_fixture()
      animal = animal_fixture(scope)
      assert %Ecto.Changeset{} = Discovery.change_animal(scope, animal)
    end
  end

  describe "colors" do
    alias FamilyFoundations.Discovery.Color

    import FamilyFoundations.AccountsFixtures, only: [user_scope_fixture: 0]
    import FamilyFoundations.DiscoveryFixtures

    @invalid_attrs %{hex_code: nil, rgb_value: nil}

    test "list_colors/1 returns all scoped colors" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      color = color_fixture(scope)
      other_color = color_fixture(other_scope)
      assert Discovery.list_colors(scope) == [color]
      assert Discovery.list_colors(other_scope) == [other_color]
    end

    test "get_color!/2 returns the color with given id" do
      scope = user_scope_fixture()
      color = color_fixture(scope)
      other_scope = user_scope_fixture()
      assert Discovery.get_color!(scope, color.id) == color
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_color!(other_scope, color.id) end
    end

    test "create_color/2 with valid data creates a color" do
      valid_attrs = %{hex_code: "some hex_code", rgb_value: "some rgb_value"}
      scope = user_scope_fixture()

      assert {:ok, %Color{} = color} = Discovery.create_color(scope, valid_attrs)
      assert color.hex_code == "some hex_code"
      assert color.rgb_value == "some rgb_value"
      assert color.user_id == scope.user.id
    end

    test "create_color/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Discovery.create_color(scope, @invalid_attrs)
    end

    test "update_color/3 with valid data updates the color" do
      scope = user_scope_fixture()
      color = color_fixture(scope)
      update_attrs = %{hex_code: "some updated hex_code", rgb_value: "some updated rgb_value"}

      assert {:ok, %Color{} = color} = Discovery.update_color(scope, color, update_attrs)
      assert color.hex_code == "some updated hex_code"
      assert color.rgb_value == "some updated rgb_value"
    end

    test "update_color/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      color = color_fixture(scope)

      assert_raise MatchError, fn ->
        Discovery.update_color(other_scope, color, %{})
      end
    end

    test "update_color/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      color = color_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Discovery.update_color(scope, color, @invalid_attrs)
      assert color == Discovery.get_color!(scope, color.id)
    end

    test "delete_color/2 deletes the color" do
      scope = user_scope_fixture()
      color = color_fixture(scope)
      assert {:ok, %Color{}} = Discovery.delete_color(scope, color)
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_color!(scope, color.id) end
    end

    test "delete_color/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      color = color_fixture(scope)
      assert_raise MatchError, fn -> Discovery.delete_color(other_scope, color) end
    end

    test "change_color/2 returns a color changeset" do
      scope = user_scope_fixture()
      color = color_fixture(scope)
      assert %Ecto.Changeset{} = Discovery.change_color(scope, color)
    end
  end

  describe "shapes" do
    alias FamilyFoundations.Discovery.Shape

    import FamilyFoundations.AccountsFixtures, only: [user_scope_fixture: 0]
    import FamilyFoundations.DiscoveryFixtures

    @invalid_attrs %{sides_count: nil, is_2d: nil}

    test "list_shapes/1 returns all scoped shapes" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      shape = shape_fixture(scope)
      other_shape = shape_fixture(other_scope)
      assert Discovery.list_shapes(scope) == [shape]
      assert Discovery.list_shapes(other_scope) == [other_shape]
    end

    test "get_shape!/2 returns the shape with given id" do
      scope = user_scope_fixture()
      shape = shape_fixture(scope)
      other_scope = user_scope_fixture()
      assert Discovery.get_shape!(scope, shape.id) == shape
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_shape!(other_scope, shape.id) end
    end

    test "create_shape/2 with valid data creates a shape" do
      valid_attrs = %{sides_count: 42, is_2d: true}
      scope = user_scope_fixture()

      assert {:ok, %Shape{} = shape} = Discovery.create_shape(scope, valid_attrs)
      assert shape.sides_count == 42
      assert shape.is_2d == true
      assert shape.user_id == scope.user.id
    end

    test "create_shape/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Discovery.create_shape(scope, @invalid_attrs)
    end

    test "update_shape/3 with valid data updates the shape" do
      scope = user_scope_fixture()
      shape = shape_fixture(scope)
      update_attrs = %{sides_count: 43, is_2d: false}

      assert {:ok, %Shape{} = shape} = Discovery.update_shape(scope, shape, update_attrs)
      assert shape.sides_count == 43
      assert shape.is_2d == false
    end

    test "update_shape/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      shape = shape_fixture(scope)

      assert_raise MatchError, fn ->
        Discovery.update_shape(other_scope, shape, %{})
      end
    end

    test "update_shape/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      shape = shape_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Discovery.update_shape(scope, shape, @invalid_attrs)
      assert shape == Discovery.get_shape!(scope, shape.id)
    end

    test "delete_shape/2 deletes the shape" do
      scope = user_scope_fixture()
      shape = shape_fixture(scope)
      assert {:ok, %Shape{}} = Discovery.delete_shape(scope, shape)
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_shape!(scope, shape.id) end
    end

    test "delete_shape/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      shape = shape_fixture(scope)
      assert_raise MatchError, fn -> Discovery.delete_shape(other_scope, shape) end
    end

    test "change_shape/2 returns a shape changeset" do
      scope = user_scope_fixture()
      shape = shape_fixture(scope)
      assert %Ecto.Changeset{} = Discovery.change_shape(scope, shape)
    end
  end

  describe "media" do
    alias FamilyFoundations.Discovery.MediaAsset

    import FamilyFoundations.AccountsFixtures, only: [user_scope_fixture: 0]
    import FamilyFoundations.DiscoveryFixtures

    @invalid_attrs %{description: nil, media_type: nil, file_url: nil}

    test "list_media/1 returns all scoped media" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)
      other_media_asset = media_asset_fixture(other_scope)
      assert Discovery.list_media(scope) == [media_asset]
      assert Discovery.list_media(other_scope) == [other_media_asset]
    end

    test "get_media_asset!/2 returns the media_asset with given id" do
      scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)
      other_scope = user_scope_fixture()
      assert Discovery.get_media_asset!(scope, media_asset.id) == media_asset
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_media_asset!(other_scope, media_asset.id) end
    end

    test "create_media_asset/2 with valid data creates a media_asset" do
      valid_attrs = %{description: "some description", media_type: "some media_type", file_url: "some file_url"}
      scope = user_scope_fixture()

      assert {:ok, %MediaAsset{} = media_asset} = Discovery.create_media_asset(scope, valid_attrs)
      assert media_asset.description == "some description"
      assert media_asset.media_type == "some media_type"
      assert media_asset.file_url == "some file_url"
      assert media_asset.user_id == scope.user.id
    end

    test "create_media_asset/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Discovery.create_media_asset(scope, @invalid_attrs)
    end

    test "update_media_asset/3 with valid data updates the media_asset" do
      scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)
      update_attrs = %{description: "some updated description", media_type: "some updated media_type", file_url: "some updated file_url"}

      assert {:ok, %MediaAsset{} = media_asset} = Discovery.update_media_asset(scope, media_asset, update_attrs)
      assert media_asset.description == "some updated description"
      assert media_asset.media_type == "some updated media_type"
      assert media_asset.file_url == "some updated file_url"
    end

    test "update_media_asset/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)

      assert_raise MatchError, fn ->
        Discovery.update_media_asset(other_scope, media_asset, %{})
      end
    end

    test "update_media_asset/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Discovery.update_media_asset(scope, media_asset, @invalid_attrs)
      assert media_asset == Discovery.get_media_asset!(scope, media_asset.id)
    end

    test "delete_media_asset/2 deletes the media_asset" do
      scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)
      assert {:ok, %MediaAsset{}} = Discovery.delete_media_asset(scope, media_asset)
      assert_raise Ecto.NoResultsError, fn -> Discovery.get_media_asset!(scope, media_asset.id) end
    end

    test "delete_media_asset/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)
      assert_raise MatchError, fn -> Discovery.delete_media_asset(other_scope, media_asset) end
    end

    test "change_media_asset/2 returns a media_asset changeset" do
      scope = user_scope_fixture()
      media_asset = media_asset_fixture(scope)
      assert %Ecto.Changeset{} = Discovery.change_media_asset(scope, media_asset)
    end
  end
end
