require_relative 'lex'
require_relative 'print_line_statement'
require_relative 'print_statement'

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

    def get_next
      @last_token    = @current_token
      @current_token = get_token
      @current_token
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

    def parse()
      get_next
      statement_list()
    end

    def statement_list()
      list = []

      while(@current_token != TOKEN[:TOK_NULL])
        stmt = statement()
        list << stmt if stmt != nil
      end

      list
    end

    def statement()
      value = nil

      case @current_token
      when TOKEN[:TOK_PRINT] then
        value = parse_print_statement()
        get_next
      when TOKEN[:TOK_PRINTLN] then
        value = parse_printline_statement()
        get_next
      else
        puts "Invalid statement: #{@current_token}"
        raise 'Error'
      end

      value
    end

    def parse_print_statement()
      get_next
      e = expr

      if @current_token != TOKEN[:TOK_SEMI]
        puts "; is expected"
        raise "Error"
      end

      PrintStatement.new(e)
    end

    def parse_printline_statement()
      get_next
      e = expr

      if @current_token != TOKEN[:TOK_SEMI]
        puts "; is expected"
        raise "Error"
      end

      PrintLineStatement.new(e)
    end
  end
end