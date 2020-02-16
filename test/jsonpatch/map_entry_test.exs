defmodule Jsonpatch.MapEntryTest do
  use ExUnit.Case

  alias Jsonpatch.MapEntry

  test "convert a one dimensional map to map entries" do
    source = %{"name" => "Bob", "age" => 27}
    map_entries = MapEntry.to_map_entries(source)

    assert [
      %MapEntry{path: "/name", value: "Bob"},
      %MapEntry{path: "/age", value: 27}
    ] = map_entries
  end

  test "convert a two dimensional map to map entries" do
    address = %{"city" => "Somewhere", "street" => "Somestreet"}
    source = %{"name" => "Bob", "age" => 27, "address" => address}
    map_entries = MapEntry.to_map_entries(source)

    assert [
      %MapEntry{path: "/name", value: "Bob"},
      %MapEntry{path: "/age", value: 27},
      %MapEntry{path: "/address/street", value: "Somestreet"},
      %MapEntry{path: "/address/city", value: "Somewhere"}
    ] = map_entries
  end

  test "convert a four dimensional map to map entries" do
    source = %{"a" => %{"b" => %{"c" => %{"d" => "e"}}}}
    map_entries = MapEntry.to_map_entries(source)

    assert [
      %MapEntry{path: "/a/b/c/d", value: "e"}
    ] = map_entries
  end

  test "convert a two dimensional map with a value array" do
    languages = ["Elixir", "Erlang"]
    source = %{"name" => "Bob", "languages" => languages, "age" => 27}
    map_entries = MapEntry.to_map_entries(source)

    assert [
      %MapEntry{path: "/name", value: "Bob"},
      %MapEntry{path: "/languages/1", value: "Erlang"},
      %MapEntry{path: "/languages/0", value: "Elixir"},
      %MapEntry{path: "/age", value: 27},
    ] = map_entries
  end

  test "convert a two dimensional map with a map array" do

  end

end
