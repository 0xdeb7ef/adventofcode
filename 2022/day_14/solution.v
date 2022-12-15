import os { read_lines }
import arrays { window }

const (
	// down, down left, down right
	dirs = [[1, 0], [1, -1], [1, 1]]
)

struct Sand {
mut:
	pos    []int = [0, 500]
	frozen bool
}

fn main() {
	lines := read_lines('input.txt')!

	mut max_x := 0 // distance right -> column
	mut max_y := 0 // distance down -> row

	for l in lines {
		for c in l.split('->').map(it.trim_space()) {
			if c.split(',')[0].int() > max_x {
				max_x = c.split(',')[0].int()
			}
			if c.split(',')[1].int() > max_y {
				max_y = c.split(',')[1].int()
			}
		}
	}

	mut grid := [][]rune{len: max_y + 1, init: []rune{len: max_x * 2, init: `.`}}

	// process grid
	for l in lines {
		for c in window(l.split('->').map(it.trim_space()),
			size: 2
		) {
			left := [c[0].split(',')[0].int() - 1, c[0].split(',')[1].int()]
			right := [c[1].split(',')[0].int() - 1, c[1].split(',')[1].int()]

			x := right[0] - left[0]
			y := right[1] - left[1]

			// process X
			if x < 0 {
				for i in 0 .. -x + 1 {
					grid[left[1]][left[0] - i + 1] = `#`
				}
			} else {
				for i in 0 .. x + 1 {
					grid[left[1]][left[0] + i + 1] = `#`
				}
			}

			// process Y
			if y < 0 {
				for i in 0 .. -y + 1 {
					grid[left[1] - i][left[0] + 1] = `#`
				}
			} else {
				for i in 0 .. y + 1 {
					grid[left[1] + i][left[0] + 1] = `#`
				}
			}
		}
	}

	mut grid1 := grid.clone()
	mut grid2 := [][]rune{len: grid.len + 2, init: []rune{len: grid[0].len, init: `.`}}
	for i, g in grid {
		for j, c in g {
			grid2[i][j] = c
		}
	}

	for i, _ in grid2[0] {
		grid2[grid2.len - 1][i] = `#`
	}

	println('Part 1: ${sand_sim(mut grid1)}')
	println('Part 2: ${sand_sim(mut grid2)}')
}

fn sand_sim(mut grid [][]rune) int {
	// falling sand
	mut done := false
	mut sands := []Sand{}

	for !done {
		// create a new sand
		mut s := Sand{}

		// while it can still move
		for !s.frozen {
			mut move := false

			// try each dir
			for d in dirs {
				// if the sand falls off the screen, mark it as done
				if s.pos[0] + d[0] < 0 || s.pos[0] + d[0] >= grid.len || s.pos[1] + d[1] < 0
					|| s.pos[1] + d[1] >= grid[0].len {
					done = true
					s.frozen = true
					break
				}

				// otherwise move
				if grid[s.pos[0] + d[0]][s.pos[1] + d[1]] == `.` {
					s.pos = [s.pos[0] + d[0], s.pos[1] + d[1]]
					move = true
					break
				}
			}
			if !move {
				s.frozen = true
				if s.pos == [0, 500] {
					done = true
					sands << s
				} else {
					grid[s.pos[0]][s.pos[1]] = `o`
				}
				// for g in grid {
				// 	for c in g {
				// 		print(c)
				// 	}
				// 	println('')
				// }
				// println('-'.repeat(grid[0].len))
			}
		}

		// add it to an array
		if !done {
			sands << s
		}
	}
	return sands.len
}
