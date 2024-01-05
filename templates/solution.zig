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

    // reading line by line
    var line_no: usize = 1;
    while (reader.streamUntilDelimiter(writer, '\n', null)) : (line_no += 1) {
        defer line.clearRetainingCapacity();

        // code here
        try stdout.print("{d} {s}\n", .{ line_no, line.items });
    } else |err| switch (err) {
        error.EndOfStream => {},
        else => |e| return e,
    }
}
