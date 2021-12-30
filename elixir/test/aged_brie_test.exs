defmodule AgedBrieTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias Item.Item

  test "the item 'Aged Brie' increases in quality the older it gets" do
    quality = 15
    item = %Item{name: "Aged Brie", sell_in: 5, quality: quality}
            |> GildedRose.update_item

    expected = quality + 1

    assert item.quality == expected
  end

  test "the item 'Aged Brie' increases in quality by two after sell by date has passed" do
    quality = 15
    item = %Item{name: "Aged Brie", sell_in: -5, quality: quality}
            |> GildedRose.update_item

    expected = quality + 2

    assert item.quality == expected
  end

  test_with_params "the quality of item 'Aged Brie' stops increase if it has reached 50",
    fn (quality, expected_quality) ->
      item = %Item{name: "Aged Brie", sell_in: 15, quality: quality}
              |> GildedRose.update_item

      assert item.quality == expected_quality
    end do
      [
        {49, 50},
        {50, 50},
        {51, 50},
        {100, 50}
      ]
  end
end
