defmodule GildedRose do
  alias Item.Modifier
  alias Item.Item

  def update_quality(items), do: Enum.map(items, &update_item/1)

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{quality: quality} = item) when quality >= 50 do
    item
    |> Modifier.decrease_sell_in()
    |> Modifier.set_quality(50)
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item = Modifier.decrease_sell_in(item)
    value = Modifier.increase_value(item)

    item
    |> Modifier.increase_quality(value)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item
    |> Modifier.decrease_sell_in()
    |> Modifier.increase_quality()
  end

  def update_item(%Item{} = item) do
    item
    |> Modifier.decrease_sell_in()
    |> Modifier.decrease_quality()
  end
end
