import os
import arrays
import datatypes { Set }

fn main() {
	lines := os.read_lines('input.txt')!

	for line in lines {
		arr := []u8{len: line.len, init: line[it]}

		// Part 1
		size_1 := 4
		for i, a in arrays.window(arr, size: size_1) {
			mut set := Set[u8]{}
			set.add_all(a)
			if set.size() == size_1 {
				println('Part 1: ${i + size_1}')
				break
			}
		}

		// Part 2
		size_2 := 14
		for i, a in arrays.window(arr, size: size_2) {
			mut set := Set[u8]{}
			set.add_all(a)
			if set.size() == size_2 {
				println('Part 2: ${i + size_2}')
				break
			}
		}
	}
}
