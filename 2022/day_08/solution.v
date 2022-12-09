import os
import arrays

fn main() {
	lines := os.read_lines('example.txt')!
	mut trees := [][]int{len: lines.len, init: []int{len: lines.len}}
	mut trees_v := [][]bool{len: lines.len, init: []bool{len: lines.len}}
	mut trees_s := [][]int{len: lines.len, init: []int{len: lines.len}}

	// load forest
	for i, line in lines {
		for j, c in line {
			trees[i][j] = c.ascii_str().int()
		}
	}

	// mark edges as seen
	for i in 0 .. trees.len {
		trees_v[i][0] = true
		trees_v[i][trees.len - 1] = true
		trees_v[0][i] = true
		trees_v[trees.len - 1][i] = true
	}

	for i := 1; i < trees.len - 1; i++ {
		for j := 1; j < trees.len - 1; j++ {
			// Part 1: Looking right
			if trees[i][j] > arrays.max(trees[i][..j])! {
				trees_v[i][j] = true
			}
			mut right := trees.len - j - 1
			// Part 2: Looking right from tree
			for k, t in trees[i][j + 1..] {
				if t >= trees[i][j] {
					right = k + 1
					break
				}
			}

			mut left := j
			// Part 1: Looking left
			if trees[i][j] > arrays.max(trees[i][j + 1..])! {
				trees_v[i][j] = true
			}
			// Part 2: Looking left from tree
			for k, t in trees[i][..j].reverse() {
				if t >= trees[i][j] {
					left = k + 1
					break
				}
			}

			mut down := trees.len - i - 1
			// Part 1: Looking down
			mut temp_arr := []int{}
			for t in trees[..i] {
				temp_arr << t[j]
			}
			if trees[i][j] > arrays.max(temp_arr)! {
				trees_v[i][j] = true
			}
			temp_arr.clear()
			// Part 2: Looking down from tree
			for t in trees[i + 1..] {
				temp_arr << t[j]
			}
			for k, t in temp_arr {
				if t >= trees[i][j] {
					down = k + 1
					break
				}
			}
			temp_arr.clear()

			mut up := i
			// Part 1: Looking up
			for t in trees[i + 1..] {
				temp_arr << t[j]
			}
			if trees[i][j] > arrays.max(temp_arr)! {
				trees_v[i][j] = true
			}
			temp_arr.clear()
			// Part 2: Looking up from tree
			for t in trees[..i] {
				temp_arr << t[j]
			}
			for k, t in temp_arr.reverse() {
				if t >= trees[i][j] {
					up = k + 1
					break
				}
			}
			temp_arr.clear()

			trees_s[i][j] = up * down * left * right
		}
	}
	println('Part 1: ${arrays.flatten(trees_v).filter(it == true).len}')
	println('Part 2: ${arrays.max(arrays.flatten(trees_s))!}')
}
