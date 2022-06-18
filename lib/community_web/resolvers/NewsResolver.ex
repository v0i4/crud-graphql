defmodule CommunityWeb.NewsResolver do
  alias Community.News
  alias Community.News.Link

  def all_links(_root, _args, _info) do
    {:ok, News.list_links()}
  end

  def create_link(_root, args, _info) do
    case News.create_link(args) do
      {:ok, link} ->
        {:ok, link}

      _error ->
        {:error, "could not create link"}
    end
  end

  def update_link(_, %{id: id, post: post}, _) do
    case link = News.get_link(id) do
      %Link{} ->
        link |> News.update_link(post)

      nil ->
        {:error, "could not update.."}
    end
  end

  def delete_link(_, %{id: id}, _) do

    case link = News.get_link(id) do
      %Link{} ->
        News.delete_link(link)

      nil ->
        {:error, "could not delete.."}
    end
  end
end
