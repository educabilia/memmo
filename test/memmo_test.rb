require "test/unit"

require_relative "../lib/memmo"

class MemoTest < Test::Unit::TestCase
  def setup
    @memo = Memo.new
  end

  def test_miss
    @memo.register(:numbers) { [1, 2, 3] }

    assert_equal [1, 2, 3], @memo.get(:numbers)
  end

  def test_cache
    calls = 0

    @memo.register(:numbers) do
      calls += 1

      [1, 2, 3]
    end

    assert_equal [1, 2, 3], @memo.get(:numbers)
    assert_equal [1, 2, 3], @memo.get(:numbers)
    assert_equal 1, calls

    assert_equal [1, 2, 3], @memo[:numbers]
  end

  def test_cache_ttl
    calls = 0

    @memo.register(:numbers, ttl: 0.1) do
      calls += 1

      [1, 2, 3]
    end

    assert_equal [1, 2, 3], @memo.get(:numbers)
    assert_equal [1, 2, 3], @memo.get(:numbers)
    assert_equal 1, calls

    sleep 0.2

    assert_equal [1, 2, 3], @memo.get(:numbers)
    assert_equal 2, calls
  end
end
