import gleam/dict
import gleam/function
import gleam/int
import gleam/list
import gleam/string
import simplifile

pub fn part1() {
  let #(left_list, right_list) = get_both_lists()

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

pub fn part2() {
  let #(left_list, right_list) = get_both_lists()

  let occurrence_map =
    list.group(right_list, function.identity)
    |> dict.map_values(fn(_, value) { list.length(value) })

  let assert Ok(answer) =
    left_list
    |> list.map(fn(number) {
      case dict.get(occurrence_map, number) {
        Error(_) -> 0
        Ok(occurrences) -> occurrences
      }
      |> int.multiply(number)
    })
    |> list.reduce(int.add)

  answer
}

fn get_both_lists() {
  let filepath = "./src/day1/input.txt"

  let assert Ok(input) = simplifile.read(from: filepath)

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
}
