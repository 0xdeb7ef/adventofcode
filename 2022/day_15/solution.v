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

	println('Part 1: ${part1(sensors, beacons, 20).size()}')
	for p in get_edges(sensors, beacons, 0, 20) {
		if !part2(sensors, beacons, p) {
			println('Part 2: ${u64(p[0]) * 4000000 + u64(p[1])}')
			break
		}
	}
}

fn part1(sensors [][]int, beacons [][]int, y int) Set[int] {
	mut cov := Set[int]{}
	for i, s in sensors {
		dist := distance(s, beacons[i])
		dist_y := abs(s[1] - y)

		if dist_y <= dist {
			for d in s[0] - (dist - dist_y) .. s[0] + (dist - dist_y) {
				cov.add(d)
			}
		}
	}
	return cov
}

fn part2(sensors [][]int, beacons [][]int, p []int) bool {
	for i, s in sensors {
		if distance(p, s) <= distance(s, beacons[i]) {
			return true
		}
	}
	return false
}

fn get_edges(sensors [][]int, beacons [][]int, mini int, maxi int) [][]int {
	// TODO - Use a Set instead, to remove duplicates.
	mut edges := [][]int{}
	for i, s in sensors {
		dist := distance(s, beacons[i])

		mut min := s[0] - dist - 1
		mut max := s[0] + dist + 2

		if min < mini {
			min = mini
		}
		if max > maxi {
			max = maxi
		}

		mut t := 0
		for j in min .. (min + max) / 2 {
			edges << [j, s[1] + t]
			edges << [j, s[1] - t]
			t++
		}
		for j in (min + max) / 2 .. max {
			edges << [j, s[1] + t]
			edges << [j, s[1] - t]
			t--
		}
	}
	return edges.filter(it[0] >= mini && it[0] <= maxi && it[1] >= mini && it[1] <= maxi)
}
