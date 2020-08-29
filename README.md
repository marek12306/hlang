# Hlang
Weird and completly useless esoteric programming language with H letter and symbols.

Features:
- Interpreter
- REPL
- Translation from/to English

## Building
```
$ shards install
$ crystal build main.cr -o hl --release
```

## Examples
| File      | Result                                      |
|-----------|---------------------------------------------|
| 69        | Prints 69 on screen                         |
| abcd      | Prints letters from A to Z                  |
| abcd_loop | Prints letters from A to Z in infinite loop |
| bruh      | BRUH!                                       |
| fib       | Prints first 6 numbers of fibonacci         |
| h_kbd     | Prints H if H is pressed                    |
| thinking  | Shows thinking emoji                        |

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
| [    | executes code if register != 0 (simple if)                                  |
| ]    | end of if                                                                   |
| @    | loop index                                                                  |

Other characters are ignored.