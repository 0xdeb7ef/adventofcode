#include <iostream>
#include <string>
using namespace std;

int main(int argc, char const *argv[])
{
    int max[3] = {0};
    int sum = 0;

    for (string line; getline(cin, line);)
    {
        if (line == "")
            sum = 0;
        else
        {
            sum += stoi(line);

            if (sum > max[0])
            {
                max[2] = max[1];
                max[1] = max[0];
                max[0] = sum;
            }
            else if (sum > max[1])
            {
                max[2] = max[1];
                max[1] = sum;
            }
            else if (sum > max[2])
            {
                max[2] = sum;
            }
        }
    }
    sum = 0;
    for (int i = 0; i < 3; i++)
    {
        cout << max[i] << " ";
        sum += max[i];
    }
    cout << endl;
    cout << sum << endl;

    return 0;
}
