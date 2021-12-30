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

  test "the quality of item 'Sulfuras...' is never changes" do
    quality = 50
    item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 5, quality: quality}
            |> GildedRose.update_item

    expected = quality

    assert item.quality == expected
  end

  test "the sell in days of item 'Sulfuras...' are never decreases" do
    sell_in = 5
    item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: sell_in, quality: 16}
            |> GildedRose.update_item

    expected = sell_in

    assert item.sell_in == expected
  end

  test "the quality of item 'Backstage passes...' increases by one when sell in more then 10 days" do
    quality = 16
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 12, quality: quality}
            |> GildedRose.update_item

    expected = quality + 1

    assert item.quality == expected
  end

  test_with_params "the quality of item 'Backstage passes...' increases by two when there are 10 days or less",
    fn (quality, sell_in) ->
      item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality}
              |> GildedRose.update_item

      expected_quality = quality + 2

      assert item.quality == expected_quality
    end do
      [
        {47, 10},
        {12, 7}
      ]
  end

  test_with_params "the quality of item 'Backstage passes...' increases by three when there are 5 days or less",
    fn (quality, sell_in) ->
      item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality}
              |> GildedRose.update_item

      expected_quality = quality + 3

      assert item.quality == expected_quality
    end do
      [
        {47, 5},
        {12, 2}
      ]
  end

  test "the quality of item 'Backstage passes...' drops to 0 after sell in days passed" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 15}
            |> GildedRose.update_item

    expected = 0

    assert item.quality == expected
  end

  test "the quality of item 'Backstage passes...' does not increase after it reaches 50 even with applied rules" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49}
            |> GildedRose.update_item

    expected = 50

    assert item.quality == expected
  end
end
