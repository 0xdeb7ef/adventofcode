import os { read_lines }

fn main() {
	lines := read_lines('example.txt')!

	mut trip := 0
	mut size := 0

	for i, line in lines {
		if line.contains_any('1234567890') {
			trip = i
			size = line.trim(' ').split(' ')#[-1..][0].int()
			break
		}
	}

	mut stacks := [][]string{len: size, cap: size}
	mut stacks2 := [][]string{len: size, cap: size}

	for line in lines[..trip].reverse() {
		filt_line := line.replace('    ', ' ').split(' ')
		for i, chr in filt_line {
			if chr == '' {
				continue
			} else {
				stacks[i] << chr.trim('[]')
				stacks2[i] << chr.trim('[]')
			}
		}
	}

	for line in lines[trip + 2..] {
		count := line.split(' ')[1].int()
		from := line.split(' ')[3].int() - 1
		to := line.split(' ')[5].int() - 1

		// Part 1
		for _ in 0 .. count {
			stacks[to] << stacks[from].pop()
		}

		// Part2
		mut temp := []string{}
		for _ in 0 .. count {
			temp << stacks2[from].pop()
		}
		for _ in 0 .. count {
			stacks2[to] << temp.pop()
		}
	}

	println('Part 1: ${stacks.map(it.last()).join('')}')
	println('Part 2: ${stacks2.map(it.last()).join('')}')
}
