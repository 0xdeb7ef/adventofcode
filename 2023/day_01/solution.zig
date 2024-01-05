const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    // arena allocator
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    // file opening shenanigans
    const file = try std.fs.cwd().openFile("example.txt", .{ .mode = .read_only });
    defer file.close();

    // Zig is still extremely confusing, so I had to borrow this.
    // https://zigcc.github.io/zig-cookbook/01-01-read-file-line-by-line.html
    var buf_reader = std.io.bufferedReader(file.reader());
    const reader = buf_reader.reader();

    var line = std.ArrayList(u8).init(alloc);
    defer line.deinit();

    const writer = line.writer();

    var sum: u32 = 0;

    // reading line by line
    var line_no: usize = 1;
    while (reader.streamUntilDelimiter(writer, '\n', null)) : (line_no += 1) {
        defer line.clearRetainingCapacity();

        // code here
        var first: u8 = 0;
        var last: u8 = 0;

        for (line.items) |c| {
            if (std.ascii.isDigit(c)) {
                if (first == 0) {
                    first = c;
                }
                last = c;
            }
        }

        sum += try std.fmt.parseInt(u8, &[_]u8{ first, last }, 10);
    } else |err| switch (err) {
        error.EndOfStream => {},
        else => |e| return e,
    }

    try stdout.print("Part 1: {d}\n", .{sum});
}
