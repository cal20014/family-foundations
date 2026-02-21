defmodule FamilyFoundationsWeb.SubjectLive.Index do
  use FamilyFoundationsWeb, :live_view

  alias FamilyFoundations.Discovery
  alias FamilyFoundations.Discovery.Subject

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        My Flashcards
        <:actions>
          <.link patch={~p"/subjects/new"}>
            <.button variant="primary">New Flashcard</.button>
          </.link>
        </:actions>
      </.header>

      <.table
        id="subjects"
        rows={@streams.subjects}
      >
        <:col :let={{_id, subject}} label="Name">{subject.common_name}</:col>

        <:col :let={{_id, subject}} label="Type">
          <%= cond do %>
            <% subject.animal != nil -> %>
              <span class="badge badge-info">Animal</span>
            <% subject.color != nil -> %>
              <span class="badge badge-warning">Color</span>
            <% subject.shape != nil -> %>
              <span class="badge badge-success">Shape</span>
            <% true -> %>
              <span class="badge">Unknown</span>
          <% end %>
        </:col>

        <:action :let={{_id, subject}}>
          <.link patch={~p"/subjects/#{subject}/edit"}>Edit</.link>
        </:action>

        <:action :let={{id, subject}}>
          <.link
            phx-click={JS.push("delete", value: %{id: subject.id}) |> hide("##{id}")}
            data-confirm="Are you sure you want to delete this flashcard?"
          >
            Delete
          </.link>
        </:action>
      </.table>

      <.modal
        :if={@live_action in [:new, :edit]}
        id="subject-modal"
        show
        on_cancel={JS.patch(~p"/subjects")}
      >
        <.live_component
          module={FamilyFoundationsWeb.SubjectLive.FormComponent}
          id={@subject.id || :new}
          title={@page_title}
          action={@live_action}
          subject={@subject}
          current_scope={@current_scope}
          patch={~p"/subjects"}
        />
      </.modal>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    # Fetch all subjects for the logged-in user
    subjects = Discovery.list_subjects(socket.assigns.current_scope)

    {:ok, stream(socket, :subjects, subjects)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    subject = Discovery.get_subject!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Flashcard")
    |> assign(:subject, subject)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Flashcard")
    # Assign the user_id from the current scope to the new Subject
    |> assign(:subject, %Subject{user_id: socket.assigns.current_scope.user.id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "My Flashcards")
    |> assign(:subject, nil)
  end

  @impl true
  def handle_info({FamilyFoundationsWeb.SubjectLive.FormComponent, {:saved, subject}}, socket) do
    # This automatically updates the list when a new subject is saved in the modal
    {:noreply, stream_insert(socket, :subjects, subject)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    subject = Discovery.get_subject!(socket.assigns.current_scope, id)
    {:ok, _} = Discovery.delete_subject(socket.assigns.current_scope, subject)

    {:noreply, stream_delete(socket, :subjects, subject)}
  end
end
