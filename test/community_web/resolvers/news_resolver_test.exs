defmodule CommunityWeb.NewsResolverTest do
  use CommunityWeb.ConnCase, async: true

  alias Community.News
  alias Community.News.Link
  alias CommunityWeb.NewsResolver
  import Community.NewsFixtures

  describe "Users GraphQL CRUD" do
    test "create_user with valid data" do
      link = link_fixture()

      {:ok, created_link} =
        NewsResolver.create_link(%{}, %{url: link.url, description: link.description}, %{})

      assert created_link.url == link.url
    end

    test "create_user with invalid data" do
      assert {:error, "could not create link"} =
               NewsResolver.create_link(
                 %{},
                 %{invalid: "invalid", invalid_description: "invalid"},
                 %{}
               )
    end

    test "update_user with valid data" do
      link = link_fixture()

      {:ok, updated_link} =
        NewsResolver.update_link(
          %{},
          %{id: link.id, post: %{description: "updated desc", url: "updated url"}},
          %{}
        )

      refute link.url == updated_link.url
    end

    test "update_user with invalid id" do
      assert {:error, "could not update.."} =
               NewsResolver.update_link(
                 %{},
                 %{id: 9999, post: %{description: "updated desc", url: "updated url"}},
                 %{}
               )
    end

    test "delete_user with valid data" do
      link = link_fixture()

      {:ok, %Link{}} = NewsResolver.delete_link(%{}, %{id: link.id}, %{})

      assert News.get_link!(link.id) == nil
    end

    test "delete_user with invalid id" do
      assert {:error, "could not delete.."} = NewsResolver.delete_link(%{}, %{id: 99999}, %{})
    end

    test "list all links" do
      assert NewsResolver.all_links(%{}, %{}, %{}) == {:ok, []}
    end
  end
end
