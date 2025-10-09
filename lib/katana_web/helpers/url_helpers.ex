defmodule KatanaWeb.Helpers.UrlHelpers do
  @doc """
  Rebuilds the full URL string based in the information provided by the Plug.conn
  """

  def full_url(conn) do
    scheme = Atom.to_string(conn.scheme)
    host = conn.host

    port =
      case {conn.scheme, conn.port} do
        {:http, 80} -> ""
        {:https, 443} -> ""
        _ -> ":#{conn.port}"
      end

    path =
      (conn.script_name ++ conn.path_info)
      |> Enum.join("/")
      |> String.replace(~r{/+}, "/")

    query =
      case conn.query_string do
        "" -> ""
        qs -> "?" <> qs
      end

    "#{scheme}://#{host}#{port}/#{path}#{query}"
  end
end
