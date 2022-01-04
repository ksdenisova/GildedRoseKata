defmodule GildedRoseTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias Item.Item

  test "begin the journey of refactoring" do
    items = [%Item{name: "foo", sell_in: 0, quality: 0}]
    GildedRose.update_quality(items)
    %{name: first_item_name} = List.first(items)
    assert first_item_name == "foo"
  end

  test "decreases sell in days by one" do
    item = %Item{name: "test_item", sell_in: 5, quality: 10}
            |> GildedRose.update_item

    expected = 4

    assert item.sell_in == expected
  end

  test_with_params "the quality of an item should not be negative",
    fn (sell_in, quality, expected_quality) ->
      item = %Item{name: "test_item", sell_in: sell_in, quality: quality}
              |> GildedRose.update_item

      assert item.quality == expected_quality
    end do
      [
        {5, 10, 9},
        {2, 0, 0},
        {3, 1, 0},
        {0, 1, 0},
      ]
  end

  test_with_params "the quality of an item should not more then 50",
    fn (name, quality, expected_quality) ->
      item = %Item{name: name, sell_in: 10, quality: quality}
              |> GildedRose.update_item

      assert item.quality == expected_quality
    end do
      [
        {"test_item", 55, 50},
        {"Conjured", 50, 50},
        {"Backstage passes to a TAFKAL80ETC concert", 100, 50},
        {"Aged Brie", 58, 50},
      ]
  end
end
