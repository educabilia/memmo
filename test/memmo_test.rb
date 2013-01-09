require "test/unit"

require_relative "../lib/memmo"

class MemmoTest < Test::Unit::TestCase
  def setup
    @memmo = Memmo.new
  end

  def test_miss
    @memmo.register(:numbers) { [1, 2, 3] }

    assert_equal [1, 2, 3], @memmo.get(:numbers)
  end

  def test_cache
    calls = 0

    @memmo.register(:numbers) do
      calls += 1

      [1, 2, 3]
    end

    assert_equal [1, 2, 3], @memmo.get(:numbers)
    assert_equal [1, 2, 3], @memmo.get(:numbers)
    assert_equal 1, calls

    assert_equal [1, 2, 3], @memmo[:numbers]
  end

  def test_cache_ttl
    calls = 0

    @memmo.register(:numbers, ttl: 0.1) do
      calls += 1

      [1, 2, 3]
    end

    assert_equal [1, 2, 3], @memmo.get(:numbers)
    assert_equal [1, 2, 3], @memmo.get(:numbers)
    assert_equal 1, calls

    sleep 0.2

    assert_equal [1, 2, 3], @memmo.get(:numbers)
    assert_equal 2, calls
  end

  def test_can_be_disabled
    Memmo.enabled = false

    calls = 0

    @memmo.register(:numbers, ttl: 10) do
      calls += 1
    end

    @memmo.get(:numbers)

    assert_equal 2, calls
  end

  def teardown
    Memmo.enabled = true
  end
end
