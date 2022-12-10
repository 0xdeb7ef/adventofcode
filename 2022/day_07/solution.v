import os { read_lines }

struct Node {
mut:
	parent   &Node = unsafe { 0 }
	children map[string]&Node
	size     int
	is_dir   bool
	name     string
}

const (
	total_size = 70_000_000
	req_size   = 30_000_000
)

fn main() {
	lines := read_lines('example.txt')!

	mut nptr := unsafe { &Node(0) }
	mut dirs := map[string]&Node{}

	for line in lines {
		cmd := line.split(' ')

		match cmd[0].runes()[0] {
			`$` {
				match cmd[1] {
					'ls' {
						// Do nothing, to be quite honest...
					}
					'cd' {
						if cmd[2] == '/' {
							// Create root node
							nptr = &Node{
								size: 0
								is_dir: true
								name: '/'
							}
							nptr.parent = nptr
						} else if cmd[2] == '..' {
							// go up
							nptr = nptr.parent
						} else {
							// cd in
							nptr = nptr.children[cmd[2]]
						}
					}
					else {
						panic('Unknown function.')
					}
				}
			}
			`0`...`9` {
				// create file node if it doesn't exist
				nptr.children[cmd[1]] = &Node{
					parent: nptr
					size: cmd[0].int()
					is_dir: false
					name: cmd[1]
				}
				// recursively update dir sizes
				mut temp_ptr := nptr
				for temp_ptr != temp_ptr.parent {
					temp_ptr.size += cmd[0].int()
					temp_ptr = temp_ptr.parent
				}
			}
			`d` {
				// create dir node if it doesn't exist
				nptr.children[cmd[1]] = &Node{
					parent: nptr
					size: 0
					name: cmd[1]
					is_dir: true
				}

				// add dir to the dir list
				// need to use the parent dir name as well since
				// there are duplicate dir names in the input
				dirs['${cmd[1]}_${nptr.name}'] = nptr.children[cmd[1]]
			}
			else {
				panic('Unknown function.')
			}
		}
	}

	// go back to '/'
	for nptr != nptr.parent {
		nptr = nptr.parent
	}
	// add up all the sizes...
	for _, v in nptr.children {
		nptr.size += v.size
	}

	// Part 1
	mut sum := 0
	for _, v in dirs {
		if v.size < 100000 {
			sum += v.size
		}
	}
	println('Part 1: ${sum}')

	// Part 2
	needed_size := req_size - total_size + nptr.size
	mut accepted_dirs := []int{}
	for _, v in dirs {
		if v.size >= needed_size {
			accepted_dirs << v.size
		}
	}
	accepted_dirs.sort()
	println('Part 2: ${accepted_dirs[0]}')
}
