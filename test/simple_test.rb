require 'test_helper'

module Simple
  class SimpleTest < Minitest::Test
    def test_number
      assert Number.new(2)
      refute Number.new(2).reducible?
      assert_equal Number.new(2).inspect, "«2»"
    end

    def test_add
      assert expr = Add.new(Number.new(3), Number.new(4))
      assert expr.reducible?
      assert_equal Number.new(7), expr.reduce
      assert_equal "«3 + 4»", expr.inspect
    end

    def test_multiply
      assert expr = Multiply.new(Number.new(3), Number.new(4))
      assert expr.reducible?
      assert_equal Number.new(12), expr.reduce
      assert_equal "«3 * 4»", expr.inspect
    end

    def test_boolead
      assert Boolean.new(true)
      assert Boolean.new(false)

      refute Boolean.new(true).reducible?
      refute Boolean.new(false).reducible?

      assert_equal Boolean.new(true).inspect, "«true»"
      assert_equal Boolean.new(false).inspect, "«false»"
    end

    def test_less_than
      assert expr = LessThan.new(Number.new(3), Number.new(4))
      assert expr.reducible?
      assert_equal Boolean.new(true), expr.reduce
      assert_equal "«3 < 4»", expr.inspect
    end
  end
end
