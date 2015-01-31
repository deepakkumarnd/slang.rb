require_relative 'statement'

class PrintStatement < Statement

  def initialize(expression)
    @expression = expression
  end

  def execute(context)
    result = @expression.evaluate(context)
    print result.to_s
  end
end