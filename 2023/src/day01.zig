const std = @import("std");
const LineReader = @import("utils.zig").LineReader;
const Result = @import("utils.zig").Result;

pub fn day01(allocator: std.mem.Allocator, reader: *LineReader) anyerror!Result {
    _ = allocator;
    var result: Result = std.mem.zeroes(Result);

    var n: u32 = 0;

    while (try reader.next()) |line| : (n += 1) {
        var first: u8 = 0;
        var last: u8 = 0;

        for (line) |c| {
            if (std.ascii.isDigit(c)) {
                if (first == 0) {
                    first = c;
                }
                last = c;
            }
        }

        result.part1 += try std.fmt.parseInt(u8, &[2]u8{ first, last }, 10);
    }

    return result;
}

const testResult = @import("utils.zig").testResult;

test "day01 - Part 1" {
    try testResult("test-data/day01-01.txt", day01, .Part1, 142);
}

test "day01 - Part 2" {
    try testResult("test-data/day01-02.txt", day01, .Part2, 281);
}
