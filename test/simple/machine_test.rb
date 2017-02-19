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

    def test_assign_statement
      vm = Machine.new(
        Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
        x: Number.new(2)
      ).tap(&:run)
      assert_equal({ x: Number.new(3) }, vm.environment)

      vm = Machine.new(
        Assign.new(:y, Add.new(Variable.new(:x), Number.new(1))),
        x: Number.new(2)
      ).tap(&:run)
      assert_equal({ x: Number.new(2), y: Number.new(3) }, vm.environment)
    end

    def test_if_statement
      expr = If.new(
        Variable.new(:x),
        Assign.new(:y, Number.new(42)),
        Assign.new(:y, Number.new(24))
      )

      vm = Machine.new(expr, x: Boolean.new(true)).tap(&:run)
      assert_equal({ x: Boolean.new(true), y: Number.new(42) }, vm.environment)
    end

    def test_sequence_statement
      seq = Sequence.new(
        Sequence.new(
          Assign.new(:x, Add.new(Number.new(2000), Number.new(2))),
          Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
        ),
        Assign.new(:z, Add.new(Variable.new(:x), Variable.new(:y)))
      )

      vm = Machine.new(seq, {}).tap(&:run)
      env = { x: Number.new(2002), y: Number.new(2005), z: Number.new(4007) }
      assert_equal env, vm.environment
    end
  end
end
