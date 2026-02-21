defmodule FamilyFoundations.DiscoveryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FamilyFoundations.Discovery` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        description: "some description",
        name: "some name"
      })

    {:ok, category} = FamilyFoundations.Discovery.create_category(scope, attrs)
    category
  end

  @doc """
  Generate a subject.
  """
  def subject_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        common_name: "some common_name"
      })

    {:ok, subject} = FamilyFoundations.Discovery.create_subject(scope, attrs)
    subject
  end

  @doc """
  Generate a animal.
  """
  def animal_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        avg_size_cm: 120.5,
        avg_weight_kg: 120.5,
        diet_type: "some diet_type",
        scientific_name: "some scientific_name"
      })

    {:ok, animal} = FamilyFoundations.Discovery.create_animal(scope, attrs)
    animal
  end

  @doc """
  Generate a color.
  """
  def color_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        hex_code: "some hex_code",
        rgb_value: "some rgb_value"
      })

    {:ok, color} = FamilyFoundations.Discovery.create_color(scope, attrs)
    color
  end

  @doc """
  Generate a shape.
  """
  def shape_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        is_2d: true,
        sides_count: 42
      })

    {:ok, shape} = FamilyFoundations.Discovery.create_shape(scope, attrs)
    shape
  end

  @doc """
  Generate a media_asset.
  """
  def media_asset_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        description: "some description",
        file_url: "some file_url",
        media_type: "some media_type"
      })

    {:ok, media_asset} = FamilyFoundations.Discovery.create_media_asset(scope, attrs)
    media_asset
  end
end
