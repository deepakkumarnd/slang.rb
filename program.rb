require_relative 'slang'

module SLang
  e = BinaryExpression.new(NumericConstant.new(10), NumericConstant.new(5), '*')
  puts e.evaluate(nil);
  e = UnaryExpression.new(NumericConstant.new(10), '-')
  puts e.evaluate(nil);
end