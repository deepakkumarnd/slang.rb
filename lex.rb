module SLang
  TOKEN = {
    TOK_ILLEGAL: 1,
    TOK_PLUS: 2,
    TOK_MIN: 3,
    TOK_MUL: 4,
    TOK_DIV: 5,
    TOK_OPAREN: 6,
    TOK_CPAREN: 7,
    TOK_NUM: 8,
    TOK_NULL: 9
  }

  class Lexer

    def initialize(expr)
      @expr = expr
      @index = 0
      @length = @expr.length
      # last grabbed number from the stream
      @number = nil
    end

    def get_number
      @number
    end

    def get_token
      tok = TOKEN[:TOK_ILLEGAL]

      while ((@index < @length) && ((@expr[@index] == ' ') || (@expr[@index] == '\t'))) do
        @index = @index + 1
      end

      return TOKEN[:TOK_NULL] if @index == @length

      case(@expr[@index])
      when '+'
        @index = @index + 1
        tok = TOKEN[:TOK_PLUS]
      when '-'
        @index = @index + 1
        tok = TOKEN[:TOK_MIN]
      when '*'
        @index = @index + 1
        tok = TOKEN[:TOK_MUL]
      when '/'
        @index = @index + 1
        tok = TOKEN[:TOK_DIV]
      when '('
        @index = @index + 1
        tok = TOKEN[:TOK_OPAREN]
      when ')'
        @index = @index + 1
        tok = TOKEN[:TOK_CPAREN]
      when '0', '1', '2', '3', '4', '5', '6', '7','8', '9'
        tmp = ''
        while((@index < @length) && ((@expr[@index] == '0')||
          (@expr[@index] == '1')||
          (@expr[@index] == '2')||
          (@expr[@index] == '3')||
          (@expr[@index] == '4')||
          (@expr[@index] == '5')||
          (@expr[@index] == '6')||
          (@expr[@index] == '7')||
          (@expr[@index] == '8')||
          (@expr[@index] == '9'))) do
          tmp = tmp + @expr[@index]
          @index = @index + 1
          @number = tmp.to_i
          tok = TOKEN[:TOK_NUM]
        end
      else
        puts "Invalid symbol #{@expr[@index]}"
        raise Error
      end

      tok
    end
  end
end