defmodule CommunityWeb.SchemaTest do
  use CommunityWeb.ConnCase

  @user_query """

  query{
    allLinks{
      description
      id
    }
  }

  """

  test "query: list all links", %{conn: conn} do
    conn =
      post(conn, "/graphiql", %{
        "query" => @user_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{"allLinks" => []}
           }
  end
end
