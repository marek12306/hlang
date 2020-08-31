module HL::Generator
    def self.gen(input)
        output = ""

        i = 0
        j = 0
        while i < input.size
            print "#{(i / input.size * 100).round.to_i}% (#{i} of #{input.size})\r"

            c = input[i].ord

            if j < c
                output += "H" * (c - j)
                j = c
            else
                output += "h" * (j - c)
                j = c
            end

            output += "!"
            i += 1
        end

        output
    end
end
