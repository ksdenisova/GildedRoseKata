defmodule Item.Manager do
  alias Item.Item

  def increase_quality(%Item{quality: quality} = item) when quality < 50 do
    %Item{item | quality: quality + 1}
  end

  def increase_quality(%Item{} = item), do: item

  def decrease_quality(%Item{quality: quality} = item) when quality > 0 do
    %Item{item | quality: quality - 1}
  end

  def decrease_quality(%Item{} = item), do: item

  def drop_quality(%Item{} = item) do
    %Item{item | quality: 0}
  end

  def decrease_sell_in(%Item{sell_in: sell_in} = item) do
    %Item{item | sell_in: sell_in - 1}
  end
end
