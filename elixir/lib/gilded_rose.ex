defmodule GildedRose do
  alias Item.Manager
  alias Item.Item

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{quality: quality} = item) when quality >= 50, do: Manager.decrease_sell_in(item)

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item = Manager.increase_quality(item)

    item = cond do
            item.sell_in <= 10 ->
              Manager.increase_quality(item)
            true -> item
          end

    item = cond do
            item.sell_in < 6 ->
              Manager.increase_quality(item)
            true -> item
          end

    item = Manager.decrease_sell_in(item)

    item = cond do
            item.sell_in < 0 ->
              Manager.drop_quality(item)
            true -> item
          end
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item = Manager.increase_quality(item)
            |> Manager.decrease_sell_in

    cond do
      item.sell_in < 0 && item.quality < 50 ->
        Manager.increase_quality(item)
      true -> item
    end
  end

  def update_item(%Item{} = item) do
    item = Manager.decrease_quality(item)
            |> Manager.decrease_sell_in()

    cond do
      item.sell_in < 0 ->
        Manager.decrease_quality(item)
      true -> item
    end
  end
end
