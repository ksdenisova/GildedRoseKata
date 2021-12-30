defmodule ConjuredTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias Item.Item

  test_with_params "the quality of item 'Conjured' decreases twice as fast as normal item",
    fn (quality, sell_in, expected_quality) ->
      item = %Item{name: "Conjured", sell_in: sell_in, quality: quality}
              |> GildedRose.update_item

      assert item.quality == expected_quality
    end do
      [
        {47, 12, 45},
        {12, 0, 8}
      ]
  end
end
