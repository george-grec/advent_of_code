import day1/historian_hysteria
import day2/red_nosed_reports
import day3/mull_it_over
import gleam/int
import gleam/io

pub fn main() {
  io.println("Hello from advent_of_code!")
  io.println(
    "Day 1 - Historian Hysteria Part 1: "
    <> int.to_string(historian_hysteria.part1()),
  )
  io.println(
    "Day 1 - Historian Hysteria Part 2: "
    <> int.to_string(historian_hysteria.part2()),
  )
  io.println(
    "Day 2 - Red-Nosed Reports Part 1: "
    <> int.to_string(red_nosed_reports.part1()),
  )
  io.println(
    "Day 2 - Red-Nosed Reports Part 2: "
    <> int.to_string(red_nosed_reports.part2()),
  )
  io.println(
    "Day 3 - Mull It Over Part 1: " <> int.to_string(mull_it_over.part1()),
  )
  io.println(
    "Day 3 - Mull It Over Part 2: " <> int.to_string(mull_it_over.part2()),
  )
}
