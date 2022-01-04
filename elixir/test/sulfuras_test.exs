defmodule SulfurasTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias Item.Item

  describe "#update_item/1" do
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
  end
end
