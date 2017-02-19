require 'test_helper'

module Simple
  class MachineTest < Minitest::Test
    def test_run
      expr = Add.new(Multiply.new(Number.new(3), Number.new(4)),
                     Multiply.new(Number.new(2), Number.new(5)))

      vm = Machine.new(expr).tap(&:run)

      assert_equal Number.new(22), vm.expression
    end

    def test_env
      expr = Add.new(Variable.new(:x), Variable.new(:y))
      env = { x: Number.new(3), y: Number.new(4) }
      vm = Machine.new(expr, env).tap(&:run)
      assert_equal Number.new(7), vm.expression
    end
  end
end
