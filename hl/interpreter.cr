class HL::Interpreter
    include HL::Events

    getter r
    getter stack

    IGNORE_CHARS = ['(',')','[',']']

    def initialize(input : String = "")
        @input = input
        @r = 0_i64
        @stack = [] of Int64
        @loop_stack = [] of Array(Int64)
        @ignore = 0_i64
        @i = 0_i64
    end

    def run(reset? : Bool = true)
        reset if reset?

        while @i < @input.size
            step
        end
    end

    def append(input : String)
        @input += input
    end

    def set(input : String)
        @input = input
    end

    def reset
        @r = 0_i64
        @stack = [] of Int64
        @loop_stack = [] of Array(Int64)
        @ignore = 0_i64
        @i = 0_i64
    end

    def read_char
        h = STDIN.raw &.read_char
        return h.not_nil!.ord.to_i64 if h != nil
        0_i64
    end

    def step
        c = @input[@i]
        if !IGNORE_CHARS.includes?(c) && @ignore > 0
            @loop_stack.last[2] += 1_i64 if @loop_stack.size > 0
            return @i += 1_i64 
        end

        case c
        when 'H' then @r += 1
        when 'h' then @r -= 1
        when '!' then invoke "output", @r.chr.to_s
        when '?' then invoke "output", @r.to_s
        when ',' then @stack.push @r
        when '.' then @stack.clear
        when '_' then @r = 0_i64
        when '+' then @r = @stack.reduce {|a,b| a + b }
        when '-' then @r = @stack.reduce {|a,b| a - b }
        when '*' then @r = @stack.reduce {|a,b| a * b }
        when '/' then @r = @stack.reduce {|a,b| (a / b).round.to_i64 }
        when '<' then @r = read_char
        when '=' then @r = @stack.size > 1 && (@stack[0] == @stack[1]) ? 1_i64 : 0_i64
        when '('
            if @r > 0 || @r == -1
                @loop_stack << [@r, @i, 0_i64]
            else
                @ignore += 1_i64
            end
        when ')'
            if @loop_stack.size > 0
                @loop_stack.last[0] -= 1_i64 if @loop_stack.last[0] != -1
                @i = @loop_stack.last[1] if @loop_stack.last[0] > 0 || @loop_stack.last[0] == -1
                @loop_stack.pop if @loop_stack.last[0] == 0
            else
                @ignore -= 1_i64
            end
        when '@' then @r = @loop_stack.last[2] if @loop_stack.size > 0
        when '$' then @r = @stack.size.to_i64
        when '#' then @r = @stack[@r] if @stack.size > @r
        when '^' then @stack.delete_at(@r) if @stack.size > @r
        when '[' then @ignore += 1_i64 if @r == 0 || @ignore > 0
        when ']' then @ignore -= 1_i64 if @ignore > 0
        end

        @i += 1_i64
        @loop_stack.last[2] += 1_i64 if @loop_stack.size > 0
    end
end
