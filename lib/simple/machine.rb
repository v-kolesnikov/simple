module Simple
  class Machine < Struct.new(:statement, :environment)
    def self.new(syntax, *args)
      case syntax
      when Number, Boolean, Add, Multiply, LessThan
        ExpressionMachine
      when DoNothing, Assign, If, Sequence, While
        StatementMachine
      end.new(syntax, *args)
    end

    class ExpressionMachine < Struct.new(:expression, :environment)
      def step
        self.expression = expression.reduce(environment)
      end

      def run
        step while expression.reducible?
      end
    end

    class StatementMachine < Struct.new(:statement, :environment)
      def step
        self.statement, self.environment = statement.reduce(environment)
      end

      def run
        step while statement.reducible?
      end
    end
  end
end
