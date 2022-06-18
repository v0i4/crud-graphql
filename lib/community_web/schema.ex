defmodule CommunityWeb.Schema do
  use Absinthe.Schema

  alias CommunityWeb.NewsResolver

  object :link do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :description, non_null(:string)
  end

  input_object :link_params do
    field :url, :string
    field :description, :string
  end

  query do
    @desc "get all links"
    field :all_links, non_null(list_of(non_null(:link))) do
      resolve(&NewsResolver.all_links/3)
    end
  end

  mutation do
    @desc "create a new link"
    field :create_link, :link do
      arg :url, non_null(:string)
      arg :description, non_null(:string)

      resolve &NewsResolver.create_link/3
    end

    @desc "update a link"
    field :update_link, type: :link do
      arg :id, non_null(:id)
      arg :post, :link_params

      resolve &NewsResolver.update_link/3
    end

    @desc "delete link"
    field :delete_link, type: :link do
      arg :id, non_null(:id)

      resolve &NewsResolver.delete_link/3
    end
  end
end
