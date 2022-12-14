import os { read_file }
import arrays { sum }

struct Node {
mut:
	value    u8
	children []&Node
	parent   &Node
	br       bool
}

fn generate_graph(s string) &Node {
	mut head_node := &Node{
		br: true
	}
	head_node.parent = head_node
	mut cur_node := head_node

	for c in s[1..] {
		match c.ascii_str() {
			'[' {
				mut n := Node{
					parent: cur_node
					br: true
				}
				cur_node.children << &n
				cur_node = &n
			}
			']' {
				cur_node = cur_node.parent
			}
			',' {}
			else {
				cur_node.children << &Node{
					value: c
					parent: cur_node
				}
			}
		}
	}

	return head_node
}

// 0 means same
// 1 means right is bigger
// -1 means left is bigger
fn compare(l &Node, r &Node) int {
	lc := l.children
	rc := r.children
	mut len := 0
	mut flag := 0

	// check list length, if right is smaller, return
	if lc.len > rc.len {
		len = rc.len
		flag = -1
	} else if lc.len < rc.len {
		len = lc.len
		flag = 1
	} else {
		len = lc.len
		flag = 0
	}

	// compare each child
	for i in 0 .. len {
		// if both are lists
		if lc[i].br && rc[i].br {
			f := compare(lc[i], rc[i])
			if f != 0 {
				return f
			}
			continue
		}

		// if left is a list
		if lc[i].br && !rc[i].br {
			// convert rc to []
			n := &Node{
				br: true
				children: [&Node{
					value: rc[i].value
				}]
			}
			// compare them as lists
			f := compare(lc[i], n)
			if f != 0 {
				return f
			}
			continue
		}

		// if right is a list
		if !lc[i].br && rc[i].br {
			// convert lc to []
			n := &Node{
				br: true
				children: [&Node{
					value: lc[i].value
				}]
			}
			// compare them as lists
			f := compare(n, rc[i])
			if f != 0 {
				return f
			}
			continue
		}

		// compare their values
		if lc[i].value > rc[i].value {
			return -1
		}
		if lc[i].value < rc[i].value {
			return 1
		}
		if lc[i].value == rc[i].value {
			continue
		}
	}

	return flag
}

fn main() {
	f := read_file('input.txt')!

	lines := f.replace('10', 'Z').split('\n\n')

	mut p1 := []int{}

	for i, line in lines {
		left := line.split('\n')[0]
		right := line.split('\n')[1]

		mut g_l := generate_graph(left)
		mut g_r := generate_graph(right)

		match compare(g_l, g_r) {
			1 { p1 << i + 1 }
			else {}
		}
	}

	println('Part 1: ${sum(p1)?}')
}
