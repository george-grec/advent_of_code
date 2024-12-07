import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/string
import simplifile

pub fn part1() {
  let filepath = "./src/day2/input.txt"

  let assert Ok(input) = simplifile.read(from: filepath)

  input
  |> string.split("\n")
  |> list.filter(fn(line) { !string.is_empty(line) })
  |> list.map(fn(line) {
    string.split(line, " ")
    |> list.map(fn(number_string) {
      let assert Ok(number) = int.parse(number_string)
      number
    })
  })
  |> list.filter(is_safe)
  |> list.length
}

pub fn is_safe(all_numbers: List(Int)) {
  case all_numbers {
    [] -> True
    [_] -> True
    [x, y, ..] -> {
      case int.compare(x, y) {
        order.Eq -> False
        order.Gt -> is_safe_recursive(all_numbers, False)
        order.Lt -> is_safe_recursive(all_numbers, True)
      }
    }
  }
}

fn is_safe_recursive(numbers: List(Int), ascending: Bool) {
  case numbers, ascending {
    [], _ -> True
    [_], _ -> True
    [x, y, ..numbers], True ->
      x < y && { y - x } <= 3 && is_safe_recursive([y, ..numbers], True)
    [x, y, ..numbers], False ->
      x > y && { x - y } <= 3 && is_safe_recursive([y, ..numbers], False)
  }
}

pub fn part2() {
  let filepath = "./src/day2/input.txt"

  let assert Ok(input) = simplifile.read(from: filepath)

  input
  |> string.split("\n")
  |> list.filter(fn(line) { !string.is_empty(line) })
  |> list.map(fn(line) {
    string.split(line, " ")
    |> list.map(fn(number_string) {
      let assert Ok(number) = int.parse(number_string)
      number
    })
  })
  |> list.filter(fn(line) {
    case line {
      [] -> True
      [first, ..rest] ->
        is_safe_with_problem_dampener_recursive([], first, rest, False)
    }
  })
  |> list.length
}

pub fn is_safe_with_problem_dampener_recursive(
  previous: List(Int),
  current: Int,
  remaining: List(Int),
  dampened: Bool,
) {
  case is_safe(list.append(previous, [current, ..remaining])) {
    False ->
      case dampened {
        False -> {
          case remaining {
            [] -> is_safe(previous)
            [next, ..rest] -> {
              let without_current =
                is_safe_with_problem_dampener_recursive(
                  previous,
                  next,
                  rest,
                  True,
                )
              let with_current =
                is_safe_with_problem_dampener_recursive(
                  list.append(previous, [current]),
                  next,
                  rest,
                  False,
                )
              without_current || with_current
            }
          }
        }
        True -> False
      }
    True -> True
  }
}
