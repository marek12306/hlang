# Hlang
Weird and completly useless esoteric programming language with H letter and symbols.

Features:
- Interpreter
- REPL
- Translation from/to English

## Building
$ shards install
$ crystal build main.cr -o hl --release

## Specification

- 1 64-bit register
- 1 stack of 64-bit integers

| Char | Effect                                                                      |
|------|-----------------------------------------------------------------------------|
| H    | adds 1 to register                                                          |
| h    | substracts 1 from register                                                  |
| !    | prints unicode character from register                                      |
| ?    | prints number from register                                                 |
| ,    | adds number from register to stack                                          |
| .    | resets stack                                                                |
| _    | resets register                                                             |
| +    | adds all numbers from stack to register                                     |
| -    | substracts all numbers from stack to register                               |
| *    | multiplies all numbers from stack to register                               |
| /    | divides all numbers from stack to register                                  |
| <    | gets char input from stdin                                                  |
| =    | sets register to 1 if first item of stack is equal to second else sets to 0 |
| (    | loops as many times as there are in register                                |
| )    | loop end                                                                    |
| @    | loop index                                                                  |

Other characters are ignored.