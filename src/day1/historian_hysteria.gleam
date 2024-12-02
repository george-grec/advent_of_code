import gleam/int
import gleam/list
import gleam/string
import simplifile

pub fn solve() {
  let filepath = "./src/day1/input.txt"

  let assert Ok(input) = simplifile.read(from: filepath)

  let #(left_list, right_list) =
    input
    |> string.split("\n")
    |> list.filter(fn(line) { !string.is_empty(line) })
    |> list.map(fn(number_pair) {
      let assert Ok(#(left, right)) = string.split_once(number_pair, "   ")
      let assert Ok(left_number) = int.parse(left)
      let assert Ok(right_number) = int.parse(right)
      #(left_number, right_number)
    })
    |> list.unzip

  let sorted_left_list = left_list |> list.sort(int.compare)
  let sorted_right_list = right_list |> list.sort(int.compare)

  let assert Ok(answer) =
    list.map2(sorted_left_list, sorted_right_list, fn(left, right) {
      case left > right {
        False -> right - left
        True -> left - right
      }
    })
    |> list.reduce(int.add)

  answer
}
