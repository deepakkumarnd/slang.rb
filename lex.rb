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
    TOK_NULL: 9,
    TOK_PRINT: 10,
    TOK_PRINTLN: 11,
    TOK_UNQUOTED_STRING: 12,
    TOK_SEMI: 13
  }

  class ValueTable
    attr_accessor :token, :value

    def initialize(token, value)
      @token = token
      @value = value
    end

    def self.init
      vt = []
      vt << ValueTable.new(TOKEN[:TOK_PRINT], 'PRINT')
      vt << ValueTable.new(TOKEN[:TOK_PRINTLN], 'PRINTLINE')
    end
  end

  class Lexer

    def initialize(expr)
      @expr   = expr
      @index  = 0
      @length = @expr.length
      # last grabbed number from the stream
      @number = nil
      @value_table = ValueTable.init
    end

    def get_number
      @number
    end

    def advance_index!
      @index = @index + 1
    end

    def get_token
      tok = TOKEN[:TOK_ILLEGAL]

      while ((@index < @length) && whitespace?(@expr[@index])) do
        advance_index!
      end


      return TOKEN[:TOK_NULL] if @index == @length

      case(@expr[@index])
      when '+'
        advance_index!
        tok = TOKEN[:TOK_PLUS]
      when '-'
        advance_index!
        tok = TOKEN[:TOK_MIN]
      when '*'
        advance_index!
        tok = TOKEN[:TOK_MUL]
      when '/'
        advance_index!
        tok = TOKEN[:TOK_DIV]
      when '('
        advance_index!
        tok = TOKEN[:TOK_OPAREN]
      when ')'
        advance_index!
        tok = TOKEN[:TOK_CPAREN]
      when ';'
        advance_index!
        tok = TOKEN[:TOK_SEMI]
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
          advance_index!
          @number = tmp.to_i
          tok = TOKEN[:TOK_NUM]
        end
      else
        if letter?(@expr[@index])
          tok = TOKEN[:TOK_UNQUOTED_STRING]

          tmp = @expr[@index]
          advance_index!

          while((@index < @length) && letter_or_digit?(@expr[@index]) || (@expr[@index] == '_'))
            tmp << @expr[@index]
            advance_index!
          end

          tmp.upcase!

          @value_table.each do |vt|
            if vt.value == tmp
              tok = vt.token
              break
            end
          end
        else
          puts "Invalid symbol #{@expr[@index]}"
          raise "Error"
        end
      end

      tok
    end

    private

    def letter_or_digit?(el)
      letter?(el) || digit?(el)
    end

    def letter?(el)
      el =~ /[[:alpha:]]/
    end

    def digit?(el)
      el =~ /[[:digit:]]/
    end

    def whitespace?(el)
      [" ", "\t", "\n", "\r"].include?(el)
    end
  end
end