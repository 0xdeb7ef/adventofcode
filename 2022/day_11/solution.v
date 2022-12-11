import os { read_file }

struct Monkey {
pub mut:
	ins   u64
	items []u64
	op    fn (u64, u64) u64
	am    u64
	test  u64
	t     &Monkey = unsafe { 0 }
	f     &Monkey = unsafe { 0 }
}

fn main() {
	file := read_file('input.txt')!
	lines := file.split('\n\n')

	mut monkeys_1 := []Monkey{len: lines.len, init: Monkey{}}
	mut monkeys_2 := []Monkey{len: lines.len, init: Monkey{}}

	for i, l in lines {
		f := l.split('\n')
		// Items
		monkeys_1[i].items << f[1].trim_space().split('Starting items: ')[1].split(', ').map(it.u64())
		monkeys_2[i].items << f[1].trim_space().split('Starting items: ')[1].split(', ').map(it.u64())

		// Operation
		match f[2].fields()[4] {
			'+' {
				monkeys_1[i].op = add
				monkeys_2[i].op = add
			}
			'*' {
				monkeys_1[i].op = mul
				monkeys_2[i].op = mul
			}
			else {
				panic('Invalid operation.')
			}
		}

		// Amount
		monkeys_1[i].am = f[2].fields()[5].u64()
		monkeys_2[i].am = f[2].fields()[5].u64()

		// Test
		monkeys_1[i].test = f[3].fields()[3].u64()
		monkeys_2[i].test = f[3].fields()[3].u64()

		// if True
		monkeys_1[i].t = unsafe { &monkeys_1[f[4].fields()[5].int()] }
		monkeys_2[i].t = unsafe { &monkeys_2[f[4].fields()[5].int()] }

		// if False
		monkeys_1[i].f = unsafe { &monkeys_1[f[5].fields()[5].int()] }
		monkeys_2[i].f = unsafe { &monkeys_2[f[5].fields()[5].int()] }
	}

	// 20 rounds, part 1
	for _ in 0 .. 20 {
		for mut monkey in monkeys_1 {
			monkey.items = monkey.items.map(monkey.op(it, (monkey.am)) / 3)
			mut tee := monkey.items.filter(it % (monkey.test) == (0))
			mut fal := monkey.items.filter(it % (monkey.test) != (0))
			monkey.ins += u64(monkey.items.len)
			monkey.items.clear()
			monkey.t.items << tee
			monkey.f.items << fal
		}
	}
	mut ins := monkeys_1.map(it.ins)
	ins.sort(a > b)
	println('Part 1: ${ins[0] * ins[1]}')
	ins.clear()

	/*
	* We are working with rather large numbers here.
	* However, we have a finite amount of monkeys.
	* And the testing operation is a modulo.
	* Therefore, we can multiply all the tests together.
	* This allows us work in a finite Galois Field.
	*/
	mut prod := monkeys_2[0].test
	for m in monkeys_2[1..] {
		prod = prod * m.test
	}

	// 10000 rounds, part 2
	for _ in 0 .. 10000 {
		for mut monkey in monkeys_2 {
			monkey.items = monkey.items.map(monkey.op(it, (monkey.am)) % prod)
			mut tee := monkey.items.filter(it % (monkey.test) == (0))
			mut fal := monkey.items.filter(it % (monkey.test) != (0))
			monkey.ins += u64(monkey.items.len)
			monkey.items.clear()
			monkey.t.items << tee
			monkey.f.items << fal
		}
	}

	ins = monkeys_2.map(it.ins)
	ins.sort(a > b)
	println('Part 2: ${ins[0] * ins[1]}')
}

fn mul(old u64, a u64) u64 {
	if a == 0 {
		return old * old
	}
	return old * a
}

fn add(old u64, a u64) u64 {
	return old + a
}
