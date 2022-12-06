#include <cstring>
#include <iostream>
#include <sstream>
#include <stack>
#include <string>
using namespace std;

#define STACKS 3

int main(int argc, char const *argv[])
{
    stack<char> Stacks[STACKS];

    /*
     *    GOD KNOWS IM NOT
     * PROCESSING THIS IN CODE
     *
     *      [D]
     *  [N] [C]
     *  [Z] [M] [P]
     *   1   2   3
     */

    for (auto c : "ZN")
        Stacks[0].push(c);
    for (auto c : "MCD")
        Stacks[1].push(c);
    for (auto c : "P")
        Stacks[2].push(c);

    // removing the NULL byte at the end :)
    for (int i = 0; i < STACKS; i++)
    {
        Stacks[i].pop();
    }

    for (string line; getline(cin, line);)
    {
        // skips until the first move
        if (line.find("move"))
            continue;

        // C++ Black Magic to split strings by spaces
        string temp;
        stringstream SS(line);
        int count = 0;
        int from = 0;
        int to = 0;

        // C++ Black Magic Part 2: Electric Boogaloo
        for (int i = 0; getline(SS, temp, ' '); i++)
        {
            switch (i)
            {
            case 1:
                count = stoi(temp);
                break;
            case 3:
                from = stoi(temp) - 1;
                break;
            case 5:
                to = stoi(temp) - 1;
                break;

            default:
                break;
            }
        }

        /* Part 1 */
        // for (int i = 0; i < count; i++)
        // {
        //     Stacks[to].push(Stacks[from].top());
        //     Stacks[from].pop();
        // }

        /* Part 2 */
        /* Unfortunately, you will have to comment out the part
         * you don't want to run, as well as manually having to
         * enter the initial configuration :')
         */
        stack<char> temp_stack;
        for (int i = 0; i < count; i++)
        {
            temp_stack.push(Stacks[from].top());
            Stacks[from].pop();
        }
        for (int i = 0; i < count; i++)
        {
            Stacks[to].push(temp_stack.top());
            temp_stack.pop();
        }
    }
    for (int i = 0; i < STACKS; i++)
    {
        cout << i + 1 << ": ";
        while (!Stacks[i].empty())
        {
            cout << "[" << Stacks[i].top() << "] ";
            Stacks[i].pop();
        }
        cout << endl;
    }

    return 0;
}
