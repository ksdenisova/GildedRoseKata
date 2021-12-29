defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{name: name} = item) do
    item = cond do
      name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
        if item.quality > 0 do
          decrease_quality(item)
        else
          item
        end
      true ->
        cond do
          item.quality < 50 ->
            item = increase_quality(item)
            cond do
              item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                item = cond do
                  item.sell_in < 11 ->
                    cond do
                      item.quality < 50 ->
                        increase_quality(item)
                      true -> item
                    end
                  true -> item
                end
                cond do
                  item.sell_in < 6 ->
                    cond do
                      item.quality < 50 ->
                        increase_quality(item)
                      true -> item
                    end
                  true -> item
                end
              true -> item
            end
          true -> item
        end
    end

    item = decrease_sell_in(item)

    cond do
      item.sell_in < 0 ->
        cond do
          name != "Aged Brie" ->
            cond do
              name != "Backstage passes to a TAFKAL80ETC concert" ->
                cond do
                  item.quality > 0 ->
                    decrease_quality(item)
                  true -> item
                end
              true -> drop_quality(item)
            end
          true ->
            cond do
              item.quality < 50 ->
                increase_quality(item)
              true -> item
            end
        end
      true -> item
    end
  end

  defp increase_quality(%Item{quality: quality} = item) do
    %Item{item | quality: quality + 1}
  end

  defp decrease_quality(%Item{quality: quality} = item) do
    %Item{item | quality: quality - 1}
  end

  defp drop_quality(%Item{quality: quality} = item) do
    %Item{item | quality: 0}
  end

  defp decrease_sell_in(%Item{sell_in: sell_in} = item) do
    %Item{item | sell_in: sell_in - 1}
  end
end
