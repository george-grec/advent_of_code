import day1/historian_hysteria
import day2/red_nosed_reports
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
}
