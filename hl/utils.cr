module HL::Utils
    def self.prime_factors(n)
        return [0] if n == 0
        return [1] if n == 1

        output = [] of Int32
    
        while n % 2 == 0
            output << 2
            n /= 2
        end
    
        i =  3
        while i <= Math.sqrt(n)
            while n % i == 0
                output << i
                n /= i
            end
    
            i += 2
        end
    
        output << n.to_i if n > 2
    
        output
    end
    
    def self.check_char(input, char)
        i = 0
        chars = 0
        while i < input.size
            chars += 1 if input[i] == char
            i += 1
        end
    
        chars
    end
end