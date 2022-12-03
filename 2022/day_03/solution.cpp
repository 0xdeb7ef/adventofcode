#include <iostream>
#include <string>
#include <algorithm>
#include <cstring>
#include <vector>
#include <map>
using namespace std;

int main(int argc, char const *argv[])
{
    // priorities
    // 'z' - 'a' + 1
    // 'Z' - 'A' + 27
    map<char, int> priorities;
    for (char i = 'a'; i <= 'z'; i++)
    {
        priorities[i] = i - 'a' + 1;
    }
    for (char i = 'A'; i <= 'Z'; i++)
    {
        priorities[i] = i - 'A' + 27;
    }

    int total = 0;

    for (string line; getline(cin, line);)
    {
        int n = line.size() / 2;
        char cOne[n + 1];
        char cTwo[n + 1];
        strcpy(cOne, line.substr(0, n).c_str());
        strcpy(cTwo, line.substr(n, line.size()).c_str());

        sort(cOne, cOne + n);
        sort(cTwo, cTwo + n);

        vector<char> v(line.length());
        vector<char>::iterator it, st;

        it = set_intersection(cOne, cOne + n, cTwo, cTwo + n, v.begin());
        for (st = v.begin(); st != it; st++)
        {
            total += priorities[*st];
            break;
        }
    }
    cout << total << endl;
    return 0;
}
