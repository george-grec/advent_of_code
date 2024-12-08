import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn part1() {
  let filepath = "./src/day4/input.txt"

  let assert Ok(input) = simplifile.read(from: filepath)

  let lines =
    input
    |> string.split("\n")
    |> list.filter(fn(line) { !string.is_empty(line) })

  let map =
    lines
    |> list.index_map(fn(line, line_index) {
      string.to_graphemes(line)
      |> list.index_map(fn(char, char_index) {
        #(#(line_index, char_index), char)
      })
    })
    |> list.flatten
    |> dict.from_list

  lines
  |> list.index_map(fn(line, line_index) {
    string.to_graphemes(line)
    |> list.index_map(fn(char, char_index) {
      case char {
        "X" -> {
          let north = xmas_north(line_index, char_index, map)
          let north_east = xmas_north_east(line_index, char_index, map)
          let east = xmas_east(line_index, char_index, map)
          let south_east = xmas_south_east(line_index, char_index, map)
          let south = xmas_south(line_index, char_index, map)
          let south_west = xmas_south_west(line_index, char_index, map)
          let west = xmas_west(line_index, char_index, map)
          let north_west = xmas_north_west(line_index, char_index, map)

          north
          + north_east
          + east
          + south_east
          + south
          + south_west
          + west
          + north_west
        }
        _ -> 0
      }
    })
    |> list.reduce(int.add)
    |> result.unwrap(0)
  })
  |> list.reduce(int.add)
  |> result.unwrap(0)
}

fn xmas_north(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index - 1, char_index)
  let a = get_or_blank(map, line_index - 2, char_index)
  let s = get_or_blank(map, line_index - 3, char_index)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn xmas_north_east(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index - 1, char_index + 1)
  let a = get_or_blank(map, line_index - 2, char_index + 2)
  let s = get_or_blank(map, line_index - 3, char_index + 3)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn xmas_east(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index, char_index + 1)
  let a = get_or_blank(map, line_index, char_index + 2)
  let s = get_or_blank(map, line_index, char_index + 3)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn xmas_south_east(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index + 1, char_index + 1)
  let a = get_or_blank(map, line_index + 2, char_index + 2)
  let s = get_or_blank(map, line_index + 3, char_index + 3)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn xmas_south(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index + 1, char_index)
  let a = get_or_blank(map, line_index + 2, char_index)
  let s = get_or_blank(map, line_index + 3, char_index)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn xmas_south_west(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index + 1, char_index - 1)
  let a = get_or_blank(map, line_index + 2, char_index - 2)
  let s = get_or_blank(map, line_index + 3, char_index - 3)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn xmas_west(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index, char_index - 1)
  let a = get_or_blank(map, line_index, char_index - 2)
  let s = get_or_blank(map, line_index, char_index - 3)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn xmas_north_west(
  line_index: Int,
  char_index: Int,
  map: Dict(#(Int, Int), String),
) -> Int {
  let m = get_or_blank(map, line_index - 1, char_index - 1)
  let a = get_or_blank(map, line_index - 2, char_index - 2)
  let s = get_or_blank(map, line_index - 3, char_index - 3)

  case m <> a <> s == "MAS" {
    False -> 0
    True -> 1
  }
}

fn get_or_blank(
  map: Dict(#(Int, Int), String),
  line_index: Int,
  char_index: Int,
) {
  dict.get(map, #(line_index, char_index)) |> result.unwrap("")
}
