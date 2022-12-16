import os { read_lines }
import math { abs }
import datatypes { Set }

fn distance(s []int, d []int) int {
	// Manhattan Distance
	return abs(d[0] - s[0]) + abs(d[1] - s[1])
}

fn main() {
	lines := read_lines('example.txt')!

	mut sensors := [][]int{}
	mut beacons := [][]int{}

	for l in lines {
		s_x := l.fields()[2].split('x=')[1].trim(',').int()
		s_y := l.fields()[3].split('y=')[1].trim(':').int()
		b_x := l.fields()[8].split('x=')[1].trim(',').int()
		b_y := l.fields()[9].split('y=')[1].trim(':').int()

		sensors << [s_x, s_y]
		beacons << [b_x, b_y]
	}

	// Part 1
	mut cov := Set[int]{}
	y := 10
	for i, s in sensors {
		dist := distance(s, beacons[i])
		dist_y := abs(s[1] - y)

		if dist_y <= dist {
			for d in (s[0] - (dist - dist_y)) .. (s[0] + (dist - dist_y)) {
				cov.add(d)
			}
		}
	}

	println('Part 1: ${cov.size()}')
}
