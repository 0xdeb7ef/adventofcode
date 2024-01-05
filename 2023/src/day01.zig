const std = @import("std");
const LineReader = @import("utils.zig").LineReader;
const Result = @import("utils.zig").Result;

const digits = [9][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

pub fn day01(allocator: std.mem.Allocator, reader: *LineReader) anyerror!Result {
    _ = allocator;
    var result: Result = std.mem.zeroes(Result);

    var n: u32 = 0;

    while (try reader.next()) |line| : (n += 1) {
        var part2_flag = false;

        // forward pass
        var i: usize = 0;
        while (i < line.len) : (i += 1) {
            if (std.ascii.isDigit(line[i])) {
                result.part1 += try std.fmt.parseInt(u8, &[2]u8{ line[i], '0' }, 10);
                if (!part2_flag) {
                    result.part2 += try std.fmt.parseInt(u8, &[2]u8{ line[i], '0' }, 10);
                }
                break;
            }

            if (part2_flag) continue;

            inline for (digits, 1..) |digit, k| {
                if (line.len >= i + digit.len) {
                    if (std.mem.eql(u8, line[i .. i + digit.len], digit)) {
                        result.part2 += @as(i64, @intCast(k)) * 10;
                        part2_flag = true;
                    }
                }
            }
        }

        part2_flag = false;

        // backward pass
        i = line.len;
        while (i != 0) {
            i -= 1;
            if (std.ascii.isDigit(line[i])) {
                result.part1 += try std.fmt.parseInt(u8, &[1]u8{line[i]}, 10);
                if (!part2_flag) {
                    result.part2 += try std.fmt.parseInt(u8, &[1]u8{line[i]}, 10);
                }
                break;
            }

            if (part2_flag) continue;

            inline for (digits, 1..) |digit, k| {
                if (line.len >= i + digit.len) {
                    if (std.mem.eql(u8, line[i .. i + digit.len], digit)) {
                        result.part2 += @intCast(k);
                        part2_flag = true;
                    }
                }
            }
        }
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
