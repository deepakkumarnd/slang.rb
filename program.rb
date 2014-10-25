require_relative 'slang'

module SLang
  e = BinaryExpression.new(NumericConstant.new(10), NumericConstant.new(5), '*')
  puts e.evaluate(nil);
  e = UnaryExpression.new(NumericConstant.new(10), '-')
  puts e.evaluate(nil);

  # step2
  b = ExpressionBuilder.new("-2*(3+3)")
  e = b.get_expression()
  puts e.evaluate(nil)

  b = ExpressionBuilder.new("(-2*3)+(8/2)*(3+3)")
  e = b.get_expression()
  puts e.evaluate(nil)
end