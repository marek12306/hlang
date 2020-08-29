require "benchmark"

require "./hl/hl.cr"

interpreter = HL::Interpreter.new

Benchmark.bm do |bm|
    bm.report("Blank loop x100000") { 
        interpreter.set "HHHHHHHHHH,,,,,*()"
        interpreter.run
    }
    bm.report("Loop with if x100000") {
        interpreter.set "HHHHHHHHHH,,,,,*([])"
        interpreter.run
    }
    bm.report("20 fibonacci numbers x100000") {
        interpreter.set "HHHHHHHHHH,,,,,*(._H,H,HHHHHHHHHHHHHHHHHHHH($h#+,_^))"
        interpreter.run
    }
    bm.report("Incrementing to 60 x100000") {
        interpreter.set "HHHHHHHHHH,,,,,*(._HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH)"
        interpreter.run
    }
    bm.report("Multiplication to 60 x100000") {
        interpreter.set "HHHHHHHHHH,,,,*(._HHHHHHHHHH,_HHHHHH,*)"
        interpreter.run
    }
end
