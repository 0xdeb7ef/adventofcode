#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
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
        vector<int> first;
        vector<int> second;
        for (int i = r1s; i <= r1e; i++)
            first.push_back(i);
        for (int i = r2s; i <= r2e; i++)
            second.push_back(i);

        // part 1
        if (includes(first.begin(), first.end(), second.begin(), second.end()) || includes(second.begin(), second.end(), first.begin(), first.end()))
            count++;

        // part2
        int size = first.size() <= second.size() ? first.size() : second.size();
        vector<int> intersection(size);
        set_intersection(first.begin(), first.end(), second.begin(), second.end(), intersection.begin());
        for (auto x : intersection)
        {
            if (x != 0)
            {
                count2++;
                break;
            }
        }
    }

    cout << count << endl;
    cout << count2 << endl;
    return 0;
}
