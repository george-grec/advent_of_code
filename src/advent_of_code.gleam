import day1/historian_hysteria
import gleam/int
import gleam/io

pub fn main() {
  io.println("Hello from advent_of_code!")
  io.println(
    "Day 1 - Historian Hysteria: " <> int.to_string(historian_hysteria.solve()),
  )
}