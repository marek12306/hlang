module HL::Generator
    OPTIMALIZATION_THRESHOLD = 20

    def self.gen(input, verbose)
        output = ""

        i = 0
        j = 0
        while i < input.size
            print "#{(i / input.size * 100).round.to_i}% (#{i} of #{input.size})\r" if verbose

            c = input[i].ord

            if j < c
                num = c - j
                temp = "H" * num + "!"
            else
                num = j - c
                temp = "h" * num + "!"
            end
            j = c
            
            temp = "_" + self.optimize("H" * c) + "!" if num > OPTIMALIZATION_THRESHOLD

            output += temp
            i += 1
        end

        output
    end
    
    def self.optimize(input)
        j = 0
        output = "."
        num = HL::Utils.check_char(input, 'H') - HL::Utils.check_char(input, 'h')
        factors = HL::Utils.prime_factors(num.abs)

        i = 0
        while i < factors.size
            factor = factors[i]
            if j > factor
                output += "h" * (j - factor)
            elsif factor != j
                output += "H" * (factor - j)
            end
            output += ","
            j = factor
            i += 1
        end

        output += "_h," if num < 0
    
        output += "*"
    end
end
