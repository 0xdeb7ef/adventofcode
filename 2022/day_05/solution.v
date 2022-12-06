import os
import datatypes

fn main() {
	lines := os.read_lines('input.txt')!

	mut trip := 0
	mut size := 0

	for i, line in lines {
		if line.contains_any('1234567890') {
			trip = i
			size = line.trim(' ').split(' ')#[-1..][0].int()
			break
		}
	}

	mut stacks := []datatypes.Stack[string]{len: size, init: datatypes.Stack[string]{}}
	mut stacks2 := []datatypes.Stack[string]{len: size, init: datatypes.Stack[string]{}}

	for line in lines[..trip].reverse() {
		filt_line := line.replace('    ', ' ').split(' ')
		for i, chr in filt_line {
			if chr == '' {
				continue
			} else {
				stacks[i].push(chr)
				stacks2[i].push(chr)
			}
		}
	}

	for line in lines[trip + 2..] {
		count := line.split(' ')[1].int()
		from := line.split(' ')[3].int() - 1
		to := line.split(' ')[5].int() - 1

		// Part 1
		for _ in 0 .. count {
			stacks[to].push(stacks[from].pop()!)
		}

		// Part2
		mut temp := datatypes.Stack[string]{}
		for _ in 0 .. count {
			temp.push(stacks2[from].pop()!)
		}
		for _ in 0 .. count {
			stacks2[to].push(temp.pop()!)
		}
	}

	print('Part 1: ')
	for s in stacks {
		print(s.peek()!)
	}
	println('')
	print('Part 2: ')
	for s in stacks2 {
		print(s.peek()!)
	}
	println('')
}
