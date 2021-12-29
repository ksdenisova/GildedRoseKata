defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{quality: quality} = item) when quality >= 50, do: decrease_sell_in(item)

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item = increase_quality(item)

    item = cond do
            item.sell_in <= 10 ->
              increase_quality(item)
            true -> item
          end

    item = cond do
            item.sell_in < 6 ->
              increase_quality(item)
            true -> item
          end

    item = decrease_sell_in(item)

    item = cond do
            item.sell_in < 0 ->
              drop_quality(item)
            true -> item
          end
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item = increase_quality(item)
            |> decrease_sell_in

    cond do
      item.sell_in < 0 && item.quality < 50 ->
        increase_quality(item)
      true -> item
    end
  end

  def update_item(%Item{} = item) do
    item = decrease_quality(item)
            |> decrease_sell_in()

    cond do
      item.sell_in < 0 ->
        decrease_quality(item)
      true -> item
    end
  end

  defp increase_quality(%Item{quality: quality} = item) when quality < 50 do
    %Item{item | quality: quality + 1}
  end

  defp increase_quality(%Item{} = item), do: item

  defp decrease_quality(%Item{quality: quality} = item) when quality > 0 do
    %Item{item | quality: quality - 1}
  end

  defp decrease_quality(%Item{} = item), do: item

  defp drop_quality(%Item{} = item) do
    %Item{item | quality: 0}
  end

  defp decrease_sell_in(%Item{sell_in: sell_in} = item) do
    %Item{item | sell_in: sell_in - 1}
  end
end
