const std = @import("std");
const LineReader = @import("utils.zig").LineReader;
const Result = @import("utils.zig").Result;

const Cubes = struct { green: u32 = 1, red: u32 = 1, blue: u32 = 1 };
const fields = std.meta.fields(Cubes);

pub fn day02(allocator: std.mem.Allocator, reader: *LineReader) anyerror!Result {
    _ = allocator;
    var result: Result = std.mem.zeroes(Result);

    const total_cubes = Cubes{ .red = 12, .green = 13, .blue = 14 };

    var n: u32 = 0;
    while (try reader.next()) |line| : (n += 1) {
        const col_idx = std.mem.indexOf(u8, line, ":").?;
        // const game_no = try std.fmt.parseInt(u32, line[5..col_idx], 10);
        const game_no = n + 1;
        const game = line[(col_idx + 2)..];

        var possible = true;
        var min_cubes = Cubes{};

        var game_it = std.mem.splitSequence(u8, game, "; ");
        while (game_it.next()) |g| {
            var part_it = std.mem.splitSequence(u8, g, ", ");
            while (part_it.next()) |p| {
                const space_idx = std.mem.indexOf(u8, p, " ").?;
                const val = try std.fmt.parseInt(u32, p[0..space_idx], 10);
                const color = p[(space_idx + 1)..];

                inline for (fields) |field| {
                    if (std.mem.eql(u8, color, field.name)) {
                        if (possible) {
                            possible = @field(total_cubes, field.name) >= val;
                        }
                        @field(min_cubes, field.name) = @max(@field(min_cubes, field.name), val);
                    }
                }
            }
        }

        if (possible) {
            result.part1 += game_no;
        }

        const power = min_cubes.red * min_cubes.green * min_cubes.blue;
        result.part2 += power;
    }

    return result;
}

const testResult = @import("utils.zig").testResult;

test "day02 - Part 1" {
    try testResult("test-data/day02.txt", day02, .Part1, 8);
}

test "day02 - Part 2" {
    try testResult("test-data/day02.txt", day02, .Part2, 2286);
}
