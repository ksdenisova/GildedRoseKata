defmodule Item.Modifier do
  alias Item.Item

  def increase_quality(%Item{sell_in: sell_in, quality: quality} = item) when sell_in < 0 and quality < 48 do
    %Item{item | quality: quality + 2}
  end

  def increase_quality(%Item{quality: quality} = item) when quality < 50 do
    %Item{item | quality: quality + 1}
  end

  def increase_quality(%Item{} = item), do: item

  def increase_quality(%Item{} = item, value) when value == 0, do: set_quality(item, value)

  def increase_quality(%Item{quality: quality} = item, value) when quality + value >= 50, do: set_quality(item, 50)

  def increase_quality(%Item{quality: quality} = item, value) do
    %Item{item | quality: quality + value}
  end

  def decrease_quality(%Item{quality: quality, sell_in: sell_in} = item) when quality >= 2 and sell_in <= 0 do
      %Item{item | quality: quality - 2}
  end

  def decrease_quality(%Item{quality: quality} = item) when quality > 0 do
      %Item{item | quality: quality - 1}
  end

  def decrease_quality(%Item{} = item), do: item

  def set_quality(%Item{} = item, value) do
    %Item{item | quality: value}
  end

  def decrease_sell_in(%Item{sell_in: sell_in} = item) do
    %Item{item | sell_in: sell_in - 1}
  end

  def increase_value(%Item{sell_in: sell_in}) do
    case sell_in do
      sell_in when sell_in < 0 -> 0
      sell_in when sell_in <= 5 -> 3
      sell_in when sell_in <= 10 -> 2
      _ -> 1
    end
  end
end
