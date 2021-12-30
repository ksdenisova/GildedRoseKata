defmodule ItemModifierTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias Item.Modifier
  alias Item.Item

  describe "#increase_quality/1" do
    test_with_params "increases quality by one",
      fn (quality, expected_quality) ->
        item = %Item{name: "test_item", sell_in: 5, quality: quality}
                |> Modifier.increase_quality()

        assert item.quality == expected_quality
      end do
        [
          {47, 48},
          {12, 13},
          {1, 2}
        ]
    end

    test_with_params "increases quality by two when sell in day has passed",
      fn (quality, expected_quality) ->
        item = %Item{name: "test_item", sell_in: -1, quality: quality}
                |> Modifier.increase_quality()

        assert item.quality == expected_quality
      end do
        [
          {47, 49},
          {12, 14},
          {1, 3}
        ]
    end
  end

  describe "#increase_quality/2" do
    test_with_params "increases quality by value",
      fn (quality, value, expected_quality) ->
        item = %Item{name: "test_item", sell_in: 5, quality: quality}
                |> Modifier.increase_quality(value)

        assert item.quality == expected_quality
      end do
        [
          {15, 2, 17},
          {12, 3, 15},
          {1, 1, 2}
        ]
    end

    test_with_params "set quality to 0 if value is 0",
      fn (quality, value, expected_quality) ->
        item = %Item{name: "test_item", sell_in: 10, quality: quality}
                |> Modifier.increase_quality(value)

        assert item.quality == expected_quality
      end do
        [
          {15, 0, 0},
          {12, 0, 0},
          {1, 0, 0}
        ]
    end

    test_with_params "set quality to 50 if by adding a value it is more then 50",
      fn (quality, value, expected_quality) ->
        item = %Item{name: "test_item", sell_in: 10, quality: quality}
                |> Modifier.increase_quality(value)

        assert item.quality == expected_quality
      end do
        [
          {49, 3, 50},
          {48, 2, 50},
          {49, 2, 50},
          {50, 1, 50}
        ]
    end
  end

  describe "#decrease_quality/1" do
    test_with_params "decrease quality by two when quality >= 2 and sell in day has passed",
      fn (quality, expected_quality) ->
        item = %Item{name: "test_item", sell_in: -6, quality: quality}
                |> Modifier.decrease_quality()

        assert item.quality == expected_quality
      end do
        [
          {47, 45},
          {12, 10},
          {2, 0}
        ]
    end

    test_with_params "decrease quality by one when quality is more then 0",
      fn (quality, expected_quality) ->
        item = %Item{name: "test_item", sell_in: 5, quality: quality}
                |> Modifier.decrease_quality()

        assert item.quality == expected_quality
      end do
        [
          {47, 46},
          {12, 11},
          {1, 0}
        ]
    end

    test "does nothing if quality is 0" do
      quality = 0
      item = %Item{name: "test_item", sell_in: 5, quality: quality}
              |> Modifier.decrease_quality()

      expected = quality

      assert item.quality == expected
    end
  end

  describe "#set_quality/2" do
    test_with_params "set quality to provided value",
      fn (value, expected_quality) ->
        item = %Item{name: "test_item", sell_in: 5, quality: 15}
                |> Modifier.set_quality(value)

        assert item.quality == expected_quality
      end do
        [
          {50, 50},
          {12, 12},
          {0, 0}
        ]
    end
  end

  describe "#decrease_sell_in/1" do
    test_with_params "decrease sell in date by one",
      fn (sell_in, expected_sell_in) ->
        item = %Item{name: "test_item", sell_in: sell_in, quality: 15}
                |> Modifier.decrease_sell_in()

        assert item.sell_in == expected_sell_in
      end do
        [
          {10, 9},
          {0, -1},
          {5, 4}
        ]
    end
  end

  describe "#increase_by_value/1" do
    test "returns increase value 0 if sell in day has passed" do
      aclual_value = %Item{name: "test_item", sell_in: -1, quality: 10}
                      |> Modifier.increase_by_value()

      expected = 0

      assert aclual_value == expected
    end

    test_with_params "returns increase value 3 if sell in day is less or equal 5",
      fn (sell_in) ->
        actual_value = %Item{name: "test_item", sell_in: sell_in, quality: 15}
                |> Modifier.increase_by_value()

        expected_value = 3

        assert actual_value == expected_value
      end do
        [
          {5},
          {1},
          {3}
        ]
    end

    test_with_params "returns increase value 2 if sell in day is less or equal 10",
      fn (sell_in) ->
        actual_value = %Item{name: "test_item", sell_in: sell_in, quality: 15}
                |> Modifier.increase_by_value()

        expected_value = 2

        assert actual_value == expected_value
      end do
        [
          {10},
          {8},
          {6}
        ]
    end

    test "returns increase value 1 if sell in day is more then 10" do
      aclual_value = %Item{name: "test_item", sell_in: 15, quality: 10}
                      |> Modifier.increase_by_value()

      expected = 1

      assert aclual_value == expected
    end
  end
end
