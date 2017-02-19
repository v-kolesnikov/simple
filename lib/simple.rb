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

  class DoNothing
    def to_s
      "do-nothing"
    end

    def ==(other)
      other.instance_of?(DoNothing)
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      false
    end
  end

  class Assign < Struct.new(:name, :expression)
    def to_s
      "#{name} = #{expression}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(env)
      if expression.reducible?
        [Assign.new(name, expression.reduce(env)), env]
      else
        [DoNothing.new, env.update(name => expression)]
      end
    end
  end

  class If < Struct.new(:condition, :consequence, :alternative)
    def to_s
      "if #{condition} { #{consequence} } else { #{alternative} }"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(env)
      if condition.reducible?
        [If.new(condition.reduce(env), consequence, alternative), env]
      else
        case condition
        when Boolean.new(true)  then [consequence, env]
        when Boolean.new(false) then [alternative, env]
        end
      end
    end
  end
end
