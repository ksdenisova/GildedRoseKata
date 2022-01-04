defmodule BackstagePassesTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias Item.Item

  describe "#update_item/1" do
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
end
