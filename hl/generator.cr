module HL::Generator
    def self.gen(input, verbose, method = 0)
        output = ""

        i = 0
        j = 0
        while i < input.size
            print "#{(i / input.size * 100).round.to_i}% (#{i} of #{input.size})\r" if verbose

            c = input[i].ord

            temp = ""

            if j < c
                temp += "H" * (c - j)
                j = c
            else
                temp += "h" * (j - c)
                j = c
            end

            temp += "!"
            
            # num = HL::Utils.check_char(temp, 'H') - HL::Utils.check_char(temp, 'h')
            # if num > 1 && HL::Utils.prime_factors(num).size > 1 && temp.size > 10
            #     temp = "_"+self.optimize(temp) + "!_"
            #     print "#{input[i]} "
            #     j = 0
            # end

            output += temp
            i += 1
        end

        output
    end
    
    def self.optimize(input, j = 0)
        output = "."
        num = HL::Utils.check_char(input, 'H') - HL::Utils.check_char(input, 'h')
        
        if num == 1
            output += "_H,"
        elsif num == 0
            output +=  "_,"
        else
            factors = HL::Utils.prime_factors(num)
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
    
        output += "*"
        # puts "#{input} #{output}"
        output
    end
end
