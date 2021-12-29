defmodule GildedRose do
  alias Item.Modifier

  alias Item.Item

  def update_quality(items), do: Enum.map(items, &update_item/1)

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{quality: quality} = item) when quality >= 50, do: Modifier.decrease_sell_in(item)

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item = Modifier.increase_quality(item)

    item = cond do
            item.sell_in <= 10 ->
              Modifier.increase_quality(item)
            true -> item
          end

    item = cond do
            item.sell_in < 6 ->
              Modifier.increase_quality(item)
            true -> item
          end

    item = Modifier.decrease_sell_in(item)

    item = cond do
            item.sell_in < 0 ->
              Modifier.drop_quality(item)
            true -> item
          end
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item
    |> Modifier.increase_quality()
    |> Modifier.decrease_sell_in()
  end

  def update_item(%Item{} = item) do
    item
    |> Modifier.decrease_quality()
    |> Modifier.decrease_sell_in()
  end
end
