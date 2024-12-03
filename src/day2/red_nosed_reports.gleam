import gleam/int
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
  |> list.filter(fn(line) {
    case line {
      [] -> True
      [_] -> True
      [x, y, ..] -> {
        case int.compare(x, y) {
          order.Eq -> False
          order.Gt -> is_safe(line, False)
          order.Lt -> is_safe(line, True)
        }
      }
    }
  })
  |> list.length
}

fn is_safe(numbers: List(Int), ascending: Bool) {
  case numbers, ascending {
    [], _ -> True
    [_], _ -> True
    [x, y, ..numbers], True ->
      x < y && { y - x } <= 3 && is_safe([y, ..numbers], True)
    [x, y, ..numbers], False ->
      x > y && { x - y } <= 3 && is_safe([y, ..numbers], False)
  }
}
