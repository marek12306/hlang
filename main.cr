require "option_parser"
require "readline"

require "./hl/hl.cr"

input = ""

run = false
repl = false
translator = false
to_hf = false
generator = false
verbose = false
output_file = ""

macro input_options
  parser.on("-f FILE", "--file=FILE", "File input") { |file|
    input += File.read(file)
  }
  parser.on("-i INPUT", "--input=INPUT", "Code input") { |_input| 
    input += _input
  }
end

macro no_input
  if input == ""
    STDERR.puts "No input is provided"
    STDERR.puts parser
    exit(1)
  end
end

parser = OptionParser.parse do |parser|
  parser.banner = "Hlang"
  parser.on("run", "Run program from file or flag input") do
    run = true
    parser.banner = "Hlang Interpreter"
    input_options
  end

  parser.on("translate", "Translate program from hlang to english and vice versa") do
    translator = true
    parser.banner = "Hlang code translator"
    parser.on("hf", "Translate from English to Hlang") do
      to_hf = true
      input_options
    end
    parser.on("eng", "Translate from Hlang to English") do
      to_hf = false
      input_options
    end
  end

  parser.on("generate", "Generate program from text file") do
    generator = true
    parser.on("-v", "--verbose", "Verbose mode") { 
      verbose = true 
    }
    parser.on("-o FILE", "--output=FILE", "Output to file") { |_output_file|
      output_file = _output_file
    }
    input_options
  end

  parser.on("repl", "Run REPL console") do
    parser.banner = "Hrainfuck REPL"
    repl = true
  end

  parser.on("-h", "--help", "Help") {
    puts parser
    exit(0)
  }

  parser.invalid_option do |f|
    STDERR.puts "Invalid flag: #{f}"
    STDERR.puts parser
    exit(1)
  end
end

interpreter = HL::Interpreter.new(input)
interpreter.on "output", ->(x : String) {
  print x
}

if run
  no_input

  interpreter.run
  puts
elsif translator
  no_input

  if to_hf
    puts HL::Translator.to_hl input
  else
    puts HL::Translator.to_eng input
  end
elsif generator
  no_input

  output = HL::Generator.gen input, verbose
  if output_file != ""
    File.write(output_file, output)
  else
    puts output
  end
elsif repl
  loop do
    x = Readline.readline("#{interpreter.r}> ")
    if x == "check"
      puts "Register: #{interpreter.r}
Stack: #{interpreter.stack}"
    elsif !x.nil?
      interpreter.append x
      interpreter.run false
      puts
    end
  end
else
  STDERR.puts parser
  exit(1)
end
