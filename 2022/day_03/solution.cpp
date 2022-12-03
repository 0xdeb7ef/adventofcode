#include <algorithm>
#include <iostream>
#include <map>
#include <string>
#include <vector>
using namespace std;

#define sort_vec(vec) sort(vec.begin(), vec.end())

#define str_to_vec(str, vec) \
    for (auto c : str)       \
        vec.push_back(c);

#define split_string(str, vec1, vec2)                     \
    for (int i = 0; i < str.length() / 2; i++)            \
        vec1.push_back(str[i]);                           \
    for (int i = str.length() / 2; i < str.length(); i++) \
        vec2.push_back(str[i]);

#define intersect_vec(vec1, vec2, out) set_intersection(vec1.begin(), vec1.end(), vec2.begin(), vec2.end(), out.begin());

int main(int argc, char const *argv[])
{
    // priorities
    // 'z' - 'a' + 1
    // 'Z' - 'A' + 27
    map<char, int> priorities;
    for (char i = 'a'; i <= 'z'; i++)
        priorities[i] = i - 'a' + 1;
    for (char i = 'A'; i <= 'Z'; i++)
        priorities[i] = i - 'A' + 27;

    int total = 0;
    int total2 = 0;

    for (string line; getline(cin, line);)
    {
        string line2;
        getline(cin, line2);
        string line3;
        getline(cin, line3);

        vector<char> l1, l1p1, l1p2;
        vector<char> l2, l2p1, l2p2;
        vector<char> l3, l3p1, l3p2;

        str_to_vec(line, l1);
        str_to_vec(line2, l2);
        str_to_vec(line3, l3);
        split_string(line, l1p1, l1p2);
        split_string(line2, l2p1, l2p2);
        split_string(line3, l3p1, l3p2);
        sort_vec(l1p1);
        sort_vec(l1p2);
        sort_vec(l2p1);
        sort_vec(l2p2);
        sort_vec(l3p1);
        sort_vec(l3p2);
        sort_vec(l1);
        sort_vec(l2);
        sort_vec(l3);

        // part 1
        vector<char> i1(line.length());
        vector<char> i2(line2.length());
        vector<char> i3(line3.length());
        intersect_vec(l1p1, l1p2, i1);
        intersect_vec(l2p1, l2p2, i2);
        intersect_vec(l3p1, l3p2, i3);
        total += priorities[i1[0]];
        total += priorities[i2[0]];
        total += priorities[i3[0]];

        // part 2
        vector<char> j1(line.length());
        vector<char> j2(line.length());
        intersect_vec(l1, l2, j1);
        sort_vec(j1);
        intersect_vec(j1, l3, j2);
        total2 += priorities[j2[0]];
    }
    cout << total << endl;
    cout << total2 << endl;
    return 0;
}
