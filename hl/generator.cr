module HL::Generator
    OPTIMALIZATION_THRESHOLD = 20

    def self.gen(input, verbose, method = 0)
        output = ""

        i = 0
        j = 0
        while i < input.size
            print "#{(i / input.size * 100).round.to_i}% (#{i} of #{input.size})\r" if verbose

            c = input[i].ord

            if j < c
                num = c - j
                temp = "H" * num
                j = c
            else
                num = j - c
                temp = "h" * num
                j = c
            end
            
            temp = "_" + self.optimize("H" * c) if num > OPTIMALIZATION_THRESHOLD

            temp += "!"

            output += temp
            i += 1
        end

        output
    end
    
    def self.optimize(input)
        j = 0
        output = "."
        num = HL::Utils.check_char(input, 'H') - HL::Utils.check_char(input, 'h')
        
        if num == 1
            output += "_H,"
        elsif num == 0
            output +=  "_,"
        else
            factors = HL::Utils.prime_factors(num.abs)
            factors.each do |factor|
                if factor == j
                    output += ","
                elsif j > factor
                    output += "h" * (j - factor) + ","
                else
                    output += "H" * (factor - j) + ","
                end
                j = factor
            end
        end

        output += "_h," if num < 0
    
        output += "*"
    end
end
