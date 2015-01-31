require_relative 'statement'

class PrintLineStatement < Statement
  def initialize(expression)
    @expression = expression
  end

  def execute(context)
    result = @expression.evaluate(context)
    puts result.to_s
  end
end