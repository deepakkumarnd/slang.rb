module SLang
  class AbstractBuilder; end

  class ExpressionBuilder < AbstractBuilder
    def initialize(str)
      @expr_str = str
    end

    def get_expression
      parser = RDparser.new(@expr_str);
      parser.call_expr()
    end
  end
end