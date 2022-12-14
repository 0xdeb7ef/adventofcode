import os { read_lines }
import datatypes { Queue, Set }

const (
	dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]]
)

fn is_valid(g [][]int, s []int) bool {
	if s[0] >= 0 && s[0] < g.len && s[1] >= 0 && s[1] < g[0].len {
		return true
	}
	return false
}

fn is_unblocked(g [][]int, s []int, d []int) bool {
	if g[d[0]][d[1]] <= (g[s[0]][s[1]] + 1) {
		return true
	}
	return false
}

fn neighbors(g [][]int, s []int) [][]int {
	mut r := [][]int{}
	for d in dirs {
		dd := [s[0] + d[0], s[1] + d[1]]
		if is_valid(g, dd) && is_unblocked(g, s, dd) {
			r << dd
		}
	}
	return r
}

fn bfs(g [][]int, s []int, d []int) int {
	mut q := Queue[[]int]{}
	mut seen := Set[string]{}

	// push coordinates, and number of steps
	q.push([s[0], s[1], 0])
	seen.add('${s[0]} ${s[1]}')

	for !q.is_empty() {
		c := q.pop() or { [-1, -1, -1] }

		// check if current cell is the destination
		if [c[0], c[1]] == d {
			return c[2]
		}

		// add neighbors to queue, if not seen
		for n in neighbors(g, [c[0], c[1]]) {
			if !seen.exists('${n[0]} ${n[1]}') {
				seen.add('${n[0]} ${n[1]}')
				q.push([n[0], n[1], c[2] + 1])
			}
		}
	}
	return -1
}

fn main() {
	lines := read_lines('input.txt')!

	mut grid := [][]int{len: lines.len, init: []int{len: lines[0].len}}
	mut start := []int{len: 2, cap: 2}
	mut end := []int{len: 2, cap: 2}

	// parse map
	for i, l in lines {
		for j, c in l {
			grid[i][j] = c - 'a'.bytes()[0]
		}
		s := l.index('S') or { -1 }
		e := l.index('E') or { -1 }
		if s != -1 {
			start = [i, l.index('S')?]
			grid[start[0]][start[1]] = 0
		}
		if e != -1 {
			end = [i, l.index('E')?]
			grid[end[0]][end[1]] = 'z'.bytes()[0] - 'a'.bytes()[0]
		}
	}

	println('Part 1: ${bfs(grid, start, end)}')

	// Part 2
	mut a := [][]int{}
	for i, l in grid {
		for j, c in l {
			if c == 0 {
				a << [i, j]
			}
		}
	}

	mut r := []int{}

	for x in a {
		r << bfs(grid, x, end)
	}

	r.sort()
	r = r.filter(it != -1)

	println('Part 2: ${r[0]}')
}
