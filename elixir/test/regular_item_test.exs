defmodule RegularItemTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias Item.Item

  test "decreases quality by one for regular items" do
    item = %Item{name: "test_item", sell_in: 5, quality: 10}
            |> GildedRose.update_item

    expected = 9

    assert item.quality == expected
  end

  test "decreases quality by two for regular items if sell by date has passed" do
    item = %Item{name: "test_item", sell_in: 0, quality: 10}
            |> GildedRose.update_item

    expected = 8

    assert item.quality == expected
  end
end
