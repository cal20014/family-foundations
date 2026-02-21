defmodule FamilyFoundationsWeb.SubjectLive.FormComponent do
  use FamilyFoundationsWeb, :live_component

  alias FamilyFoundations.Discovery

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Create a new flashcard for your family deck.</:subtitle>
      </.header>

      <.form
        for={@form}
        id="subject-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        class="space-y-6 mt-4"
      >
        <.input
          field={@form[:common_name]}
          type="text"
          label="Flashcard Name (e.g., Lion, Red, Square)"
          required
        />

        <.input
          field={@form[:category_id]}
          type="select"
          label="Category"
          options={@category_options}
          prompt="Choose a category"
          required
        />

        <.input
          name="subject_type"
          value={@subject_type}
          type="select"
          label="What kind of flashcard is this?"
          options={[{"Animal", "animal"}, {"Color", "color"}, {"Shape", "shape"}]}
          phx-target={@myself}
        />

        <div class="p-4 mt-4 border-2 rounded-lg border-brand/20 bg-brand/5">
          <%= if @subject_type == "animal" do %>
            <.inputs_for :let={f_animal} field={@form[:animal]}>
              <div class="space-y-4">
                <h3 class="font-bold text-brand">Animal Details</h3>
                <.input field={f_animal[:scientific_name]} type="text" label="Scientific Name" />
                <.input
                  field={f_animal[:diet_type]}
                  type="select"
                  label="Diet"
                  options={["Carnivore", "Herbivore", "Omnivore"]}
                />
                <div class="flex gap-4">
                  <.input
                    field={f_animal[:avg_weight_kg]}
                    type="number"
                    label="Weight (kg)"
                    step="0.1"
                  />
                  <.input field={f_animal[:avg_size_cm]} type="number" label="Size (cm)" step="0.1" />
                </div>
              </div>
            </.inputs_for>
          <% end %>

          <%= if @subject_type == "color" do %>
            <.inputs_for :let={f_color} field={@form[:color]}>
              <div class="space-y-4">
                <h3 class="font-bold text-brand">Color Details</h3>
                <.input field={f_color[:hex_code]} type="text" label="Hex Code (e.g., #FF0000)" />
                <.input field={f_color[:rgb_value]} type="text" label="RGB Value (e.g., 255, 0, 0)" />
              </div>
            </.inputs_for>
          <% end %>

          <%= if @subject_type == "shape" do %>
            <.inputs_for :let={f_shape} field={@form[:shape]}>
              <div class="space-y-4">
                <h3 class="font-bold text-brand">Shape Details</h3>
                <.input field={f_shape[:sides_count]} type="number" label="Number of Sides" />
                <.input field={f_shape[:is_2d]} type="checkbox" label="Is this a 2D shape?" />
              </div>
            </.inputs_for>
          <% end %>
        </div>

        <div class="mt-6 flex items-center justify-end gap-x-6">
          <.button phx-disable-with="Saving..." variant="primary" class="w-full">
            Save Flashcard
          </.button>
        </div>
      </.form>
    </div>
    """
  end

  @impl true
  def update(%{subject: subject, current_scope: scope} = assigns, socket) do
    changeset = Discovery.change_subject(scope, subject)
    categories = Discovery.list_categories(scope)
    category_options = Enum.map(categories, &{&1.name, &1.id})

    # Determine default form type based on existing data
    subject_type = determine_type(subject)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:category_options, category_options)
     |> assign(:subject_type, subject_type)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"subject" => subject_params} = params, socket) do
    # Capture the un-nested subject_type from the form
    subject_type = params["subject_type"] || socket.assigns.subject_type

    changeset =
      socket.assigns.current_scope
      |> Discovery.change_subject(socket.assigns.subject, subject_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:subject_type, subject_type) |> assign_form(changeset)}
  end

  @impl true
  def handle_event("save", %{"subject" => subject_params}, socket) do
    save_subject(socket, socket.assigns.action, subject_params)
  end

  defp save_subject(socket, :edit, subject_params) do
    case Discovery.update_subject(
           socket.assigns.current_scope,
           socket.assigns.subject,
           subject_params
         ) do
      {:ok, subject} ->
        notify_parent({:saved, subject})

        {:noreply,
         socket
         |> put_flash(:info, "Flashcard updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_subject(socket, :new, subject_params) do
    case Discovery.create_subject(socket.assigns.current_scope, subject_params) do
      {:ok, subject} ->
        notify_parent({:saved, subject})

        {:noreply,
         socket
         |> put_flash(:info, "Flashcard created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp determine_type(subject) do
    cond do
      subject.color != nil -> "color"
      subject.shape != nil -> "shape"
      # Default
      true -> "animal"
    end
  end
end
