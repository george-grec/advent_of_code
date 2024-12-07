import gleam/int
import gleam/string
import simplifile

pub fn part1() {
  let filepath = "./src/day3/input.txt"

  let assert Ok(input) = simplifile.read(from: filepath)
  parse_mul(input)
}

fn parse_mul(input: String) {
  parse_mul_rec(input, START, 0)
}

/// parse with state machine
fn parse_mul_rec(input: String, state: State, acc: Int) -> Int {
  case string.pop_grapheme(input) {
    Error(_) -> acc
    Ok(#(grapheme, rest)) -> {
      case state {
        M -> {
          case grapheme {
            "u" -> parse_mul_rec(rest, MU, acc)
            _ -> parse_mul_rec(input, START, acc)
          }
        }
        MUL1(a) -> {
          case grapheme {
            "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> {
              case string.length(a) < 3 {
                False -> parse_mul_rec(input, START, acc)
                True -> parse_mul_rec(rest, MUL1(a <> grapheme), acc)
              }
            }
            "," -> {
              case string.length(a) != 0 {
                False -> parse_mul_rec(input, START, acc)
                True -> {
                  case int.parse(a) {
                    Error(_) -> panic
                    Ok(number) -> parse_mul_rec(rest, MUL2(number, ""), acc)
                  }
                }
              }
            }
            _ -> parse_mul_rec(input, START, acc)
          }
        }
        START -> {
          case grapheme {
            "m" -> parse_mul_rec(rest, M, acc)
            _ -> parse_mul_rec(rest, START, acc)
          }
        }
        MU -> {
          case grapheme {
            "l" -> parse_mul_rec(rest, MUL, acc)
            _ -> parse_mul_rec(input, START, acc)
          }
        }
        MUL -> {
          case grapheme {
            "(" -> parse_mul_rec(rest, MUL1(""), acc)
            _ -> parse_mul_rec(input, START, acc)
          }
        }
        MUL2(first_number, b) -> {
          case grapheme {
            "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> {
              case string.length(b) < 3 {
                False -> parse_mul_rec(input, START, acc)
                True ->
                  parse_mul_rec(rest, MUL2(first_number, b <> grapheme), acc)
              }
            }
            ")" -> {
              case string.length(b) != 0 {
                False -> parse_mul_rec(input, START, acc)
                True -> {
                  case int.parse(b) {
                    Error(_) -> panic
                    Ok(number) ->
                      parse_mul_rec(
                        rest,
                        START,
                        acc + { first_number * number },
                      )
                  }
                }
              }
            }
            _ -> parse_mul_rec(input, START, acc)
          }
        }
      }
    }
  }
}

type State {
  START
  M
  MU
  MUL
  MUL1(a: String)
  MUL2(a: Int, b: String)
}
