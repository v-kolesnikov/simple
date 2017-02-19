module Simple
  class Machine < Struct.new(:expression, :environment)
    def step
      self.expression = expression.reduce(environment)
    end

    def run
      step while expression.reducible?
    end
  end
end
