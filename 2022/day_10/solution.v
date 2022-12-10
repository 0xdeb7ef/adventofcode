import os { read_lines }

const (
	width  = 40
	height = 6
)

fn main() {
	lines := read_lines('example.txt')!

	mut cycles := 1
	mut x := 1
	mut sig := 0

	mut crt := []rune{len: height * width, init: `.`}

	for l in lines {
		mut sig_temp := 0
		match l.split(' ')[0] {
			'noop' {
				cycles, x, sig_temp = noop(cycles, x, mut crt)
			}
			'addx' {
				cycles, x, sig_temp = addx(cycles, x, l.split(' ')[1].int(), mut crt)
			}
			else {
				panic('Invalid instruction.')
			}
		}
		sig += sig_temp
	}

	println('Part 1: ${sig}')
	println('Part 2:')
	print_crt(crt)
}

fn draw(mut crt []rune, c int, x int) {
	if (c % width) >= x - 1 && (c % width) <= x + 1 {
		crt[c] = `#`
	}
}

fn noop(c int, x int, mut crt []rune) (int, int, int) {
	mut k := c
	mut s := 0
	// Cycles: 1
	for _ in 0 .. 1 {
		if k == 20 || (k + 20) % 40 == 0 {
			s = k * x
		}
		draw(mut crt, k - 1, x)
		k++
	}
	return k, x, s
}

fn addx(c int, x int, i int, mut crt []rune) (int, int, int) {
	mut k := c
	mut e := x
	mut s := 0
	// Cycles: 2
	for _ in 0 .. 2 {
		if k == 20 || (k + 20) % 40 == 0 {
			s = k * x
		}
		draw(mut crt, k - 1, e)
		k++
	}
	e += i

	return k, e, s
}

fn print_crt(crt []rune) {
	for i, r in crt {
		if i % width == 0 && i != 0 {
			println('')
		}
		print(r)
	}
	println('')
}
