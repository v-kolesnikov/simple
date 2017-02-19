require 'simple/machine'
require 'simple/version'

module Simple
  class Number < Struct.new(:value)
    def to_s
      value.to_s
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      false
    end
  end

  class Add < Struct.new(:left, :right)
    def to_s
      "#{left} + #{right}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(env)
      if left.reducible?
        Add.new(left.reduce(env), right)
      elsif right.reducible?
        Add.new(left, right.reduce(env))
      else
        Number.new(left.value + right.value)
      end
    end
  end

  class Multiply < Struct.new(:left, :right)
    def to_s
      "#{left} * #{right}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(env)
      if left.reducible?
        Multiply.new(left.reduce(env), right)
      elsif right.reducible?
        Multiply.new(left, right.reduce(env))
      else
        Number.new(left.value * right.value)
      end
    end
  end

  class Boolean < Struct.new(:value)
    def to_s
      value.to_s
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      false
    end
  end

  class LessThan < Struct.new(:left, :right)
    def to_s
      "#{left} < #{right}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(env)
      if left.reducible?
        LessThan.new(left.reduce(env), right)
      elsif right.reducible?
        LessThan.new(left, right.reduce(env))
      else
        Boolean.new(left.value < right.value)
      end
    end
  end

  class Variable < Struct.new(:name)
    def to_s
      name.to_s
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(env)
      env[name]
    end
  end
end
