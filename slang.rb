require_relative 'rdparser'
require_relative 'expression'
require_relative 'builder'
require_relative 'statement'

module SLang
  OPERATOR = {
    PLUS: '+',
    MIN: '-',
    MUL: '*',
    DIV: '/'
  }

  class NumericConstant < Expression
    def initialize(value)
      # a numeric value is stored in @value
      @value = value
    end

    def evaluate(ctx)
      @value
    end
  end

  class UnaryExpression < Expression
    # expression and unary operator (+/-) are passed
    def initialize(exp, op)
      @exp = exp
      @op  = op
    end

    def evaluate(ctx)
      case @op
      when OPERATOR[:PLUS] then @exp.evaluate(ctx)
      when OPERATOR[:MIN] then -@exp.evaluate(ctx)
      else
        puts 'Not an operator'
      end
    end
  end

  class BinaryExpression < Expression
    # expressions and binary operator (+/-) are passed
    def initialize(exp1, exp2, op)
      @exp1 = exp1
      @exp2 = exp2
      @op   = op
    end

    def evaluate(ctx)
      case @op
      when OPERATOR[:PLUS] then (@exp1.evaluate(ctx) + @exp2.evaluate(ctx))
      when OPERATOR[:MIN] then (@exp1.evaluate(ctx) - @exp2.evaluate(ctx))
      when OPERATOR[:MUL] then (@exp1.evaluate(ctx) * @exp2.evaluate(ctx))
      when OPERATOR[:DIV] then (@exp1.evaluate(ctx) / @exp2.evaluate(ctx))
      else
        puts 'Not an operator'
      end
    end
  end
end