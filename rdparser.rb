require_relative 'lex'

module SLang
  class RDparser < Lexer

    def initialize(str)
      @current_token = nil
      super(str)
    end

    def current_token
      @current_token
    end

    def call_expr
      @current_token = get_token()
      expr()
    end

    def expr
      rt_val = term()

      while((@current_token == TOKEN[:TOK_PLUS]) || (@current_token == TOKEN[:TOK_MIN]))
        t = @current_token
        @current_token = get_token
        e1 = term()
        rt_val = BinaryExpression.new(rt_val, e1, (t == TOKEN[:TOK_PLUS]) ? OPERATOR[:PLUS] : OPERATOR[:MIN] )
      end

      rt_val
    end

    def term
      rt_val = factor()

      while((@current_token == TOKEN[:TOK_MUL]) || (@current_token == TOKEN[:TOK_DIV]))
        t = @current_token
        @current_token = get_token
        e1 = term()
        rt_val = BinaryExpression.new(rt_val, e1, (t == TOKEN[:TOK_MUL]) ? OPERATOR[:MUL] : OPERATOR[:DIV])
      end

      rt_val
    end

    def factor
      ret_val = nil

      if(@current_token == TOKEN[:TOK_NUM])
        ret_val = NumericConstant.new(get_number())
        @current_token = get_token()
      elsif @current_token == TOKEN[:TOK_OPAREN]
        @current_token = get_token()
        ret_val = expr()

        if @current_token != TOKEN[:TOK_CPAREN]
          puts "Missing closing paranthesis"
          raise Error
        end

        @current_token = get_token
      elsif @current_token == TOKEN[:TOK_PLUS] || @current_token == TOKEN[:TOK_MIN]
        t = @current_token
        @current_token = get_token
        ret_val = factor()
        ret_val = UnaryExpression.new(ret_val, (t == TOKEN[:TOK_PLUS]) ? OPERATOR[:PLUS] : OPERATOR[:MIN])
      else
        puts "Illegal token"
        raise Error
      end

      ret_val
    end
  end
end