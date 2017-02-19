module Simple
  class Machine < Struct.new(:expression)
    def step
      self.expression = expression.reduce
    end

    def run
      step while expression.reducible?
    end
  end
end
