import os
import math

struct Knot {
pub mut:
	x int
	y int
}

struct Vec {
pub mut:
	x int
	y int
}

fn (v Vec) normalize() Vec {
	mut x := 0
	mut y := 0
	if v.x > 0 {
		x = 1
	} else if v.x < 0 {
		x = -1
	}
	if v.y > 0 {
		y = 1
	} else if v.y < 0 {
		y = -1
	}
	return Vec{
		x: x
		y: y
	}
}

fn main() {
	lines := os.read_lines('example.txt')!
	lines_l := os.read_lines('example_large.txt')!

	mut knots_1 := []Knot{len: 2}
	mut knots_2 := []Knot{len: 10}

	mut locations_1 := [][]int{}
	mut locations_2 := [][]int{}

	for l in lines {
		process_cmd(l, mut knots_1, mut locations_1)
	}
	for l in lines_l {
		process_cmd(l, mut knots_2, mut locations_2)
	}

	println('Part 1: ${locations_1.len}')
	println('Part 2: ${locations_2.len}')
}

fn process_cmd(cmd string, mut k []Knot, mut loc [][]int) {
	dir := cmd.split(' ')[0]
	step := cmd.split(' ')[1].int()

	mut vec := Vec{}

	match dir {
		'U' { vec.y = 1 }
		'R' { vec.x = 1 }
		'D' { vec.y = -1 }
		'L' { vec.x = -1 }
		else { panic('Invalid move.') }
	}

	process_move(vec, mut k, step, mut loc)
}

fn process_move(vec Vec, mut k []Knot, step int, mut loc [][]int) {
	for _ in 0 .. step {
		// move head
		k[0].x += vec.x
		k[0].y += vec.y

		// go over the rest of the knots 1 by 1
		for i := 1; i < k.len; i++ {
			if calc_distance(k[i - 1], k[i]) > 1 {
				k[i].x += calc_vec(k[i - 1], k[i]).normalize().x
				k[i].y += calc_vec(k[i - 1], k[i]).normalize().y
			}
		}

		// add position to array if it doesnt exist
		if !loc.contains([k.last().x, k.last().y]) {
			loc << [k.last().x, k.last().y]
		}
	}
}

fn calc_distance(h Knot, t Knot) i64 {
	return math.sqrti((h.x - t.x) * (h.x - t.x) + (h.y - t.y) * (h.y - t.y))
}

fn calc_vec(h Knot, t Knot) Vec {
	return Vec{
		x: h.x - t.x
		y: h.y - t.y
	}
}
