#include <iostream>
#include <string>
using namespace std;

#define TOP 3

int main(int argc, char const *argv[]) {
    int max[TOP] = {0};
    int sum = 0;

    for (string line; getline(cin, line);) {
        if (line == "")
            sum = 0;
        else {
            sum += stoi(line);

            for (int i = 0; i < TOP; i++) {
                if (sum > max[i]) {
                    for (int j = TOP - 1; j > i; j--) {
                        max[j] = max[j - 1];
                    }
                    max[i] = sum;
                    break;
                }
            }
        }
    }

    sum = 0;
    for (int i = 0; i < TOP; i++) {
        cout << max[i] << " ";
        sum += max[i];
    }
    cout << endl;
    cout << sum << endl;

    return 0;
}
