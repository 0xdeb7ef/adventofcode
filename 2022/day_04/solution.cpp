#include <iostream>
#include <string>
using namespace std;

int main(int argc, char const *argv[])
{
    int count = 0;
    int count2 = 0;

    for (string line; getline(cin, line);)
    {
        // parsing
        string range1 = line.substr(0, line.find(','));
        string range2 = line.substr(line.find(',') + 1, line.size());
        int r1s = stoi(range1.substr(0, range1.find('-')));
        int r1e = stoi(range1.substr(range1.find('-') + 1, range1.size()));
        int r2s = stoi(range2.substr(0, range2.find('-')));
        int r2e = stoi(range2.substr(range2.find('-') + 1, range2.size()));

        if (((r1s >= r2s) && (r1e <= r2e)) || ((r2s >= r1s) && (r2e <= r1e)))
            count++;

        if (((r1s >= r2s) && (r1e <= r2e)) || ((r2s >= r1s) && (r2e <= r1e)) ||
            ((r1e >= r2s) && (r1e <= r2e)) || ((r1s >= r2s) && (r1s <= r2e)))
            count2++;
    }

    cout << count << endl;
    cout << count2 << endl;
    return 0;
}
