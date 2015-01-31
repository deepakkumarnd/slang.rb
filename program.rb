require_relative 'slang'

module SLang
  # step1
  puts "step1: TESTING BinaryExpression & UnaryExpression"
  e = BinaryExpression.new(NumericConstant.new(10), NumericConstant.new(5), '*')
  puts e.evaluate(nil);
  e = UnaryExpression.new(NumericConstant.new(10), '-')
  puts e.evaluate(nil);

  # step2
  puts "step2 TESTING ExpressionBuilder"
  b = ExpressionBuilder.new("-2*(3+3)")
  e = b.get_expression()
  puts e.evaluate(nil)

  b = ExpressionBuilder.new("(-2*3)+(8/2)*(3+3)")
  e = b.get_expression()
  puts e.evaluate(nil)

  # step3
  puts "step3 TESTING PRINTLINE, PRINT statements"
  e1 = "PRINTLINE 2*3; \n\rPRINTLINE (40/5)/3 ; \r"
  e1 = "PRINTLINE -2*10;" + "\r\n" + "PRINTLINE -10*-1;\r\n PRINT 2*10;\r\n"

  [e1, e1].each do |e|
    statements = RDparser.new(e).parse()

    statements.each do |st|
      st.execute(nil)
    end
  end
end