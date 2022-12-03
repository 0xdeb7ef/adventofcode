/*
 * A X = Rock     = 1
 * B Y = Paper    = 2
 * C Z = Scissors = 3
 *
 * Loss = 0
 * Draw = 3
 * Win  = 6
 *
 *    | X | Y | Z |
 *   -+---+---+---+
 *   A| 4 | 8 | 3 |
 *   -+---+---+---+
 *   B| 1 | 5 | 9 |
 *   -+---+---+---+
 *   C| 7 | 2 | 6 |
 *   -+---+---+---+
 *
 * --- Part 2 ---
 * X = Lose
 * Y = Draw
 * Z = Win
 *
 *    | X | Y | Z |
 *   -+---+---+---+
 *   A| 3 | 4 | 8 |
 *   -+---+---+---+
 *   B| 1 | 5 | 9 |
 *   -+---+---+---+
 *   C| 2 | 6 | 7 |
 *   -+---+---+---+
 */

#include <iostream>
#include <map>
#include <string>
using namespace std;

int main(int argc, char const *argv[])
{
    map<std::pair<char, char>, int> scoreMatrix;
    map<std::pair<char, char>, int> scoreMatrixTwo;

    // the score matrix based on the rules given
    scoreMatrix[make_pair('A', 'X')] = 4;
    scoreMatrix[make_pair('A', 'Y')] = 8;
    scoreMatrix[make_pair('A', 'Z')] = 3;

    scoreMatrix[make_pair('B', 'X')] = 1;
    scoreMatrix[make_pair('B', 'Y')] = 5;
    scoreMatrix[make_pair('B', 'Z')] = 9;

    scoreMatrix[make_pair('C', 'X')] = 7;
    scoreMatrix[make_pair('C', 'Y')] = 2;
    scoreMatrix[make_pair('C', 'Z')] = 6;

    // the score matrix based on the second rules
    scoreMatrixTwo[make_pair('A', 'X')] = 3;
    scoreMatrixTwo[make_pair('A', 'Y')] = 4;
    scoreMatrixTwo[make_pair('A', 'Z')] = 8;

    scoreMatrixTwo[make_pair('B', 'X')] = 1;
    scoreMatrixTwo[make_pair('B', 'Y')] = 5;
    scoreMatrixTwo[make_pair('B', 'Z')] = 9;

    scoreMatrixTwo[make_pair('C', 'X')] = 2;
    scoreMatrixTwo[make_pair('C', 'Y')] = 6;
    scoreMatrixTwo[make_pair('C', 'Z')] = 7;

    int score = 0;
    int scoreTwo = 0;

    for (string line; getline(cin, line);)
    {
        score += scoreMatrix[make_pair(line[0], line[2])];
        scoreTwo += scoreMatrixTwo[make_pair(line[0], line[2])];
    }

    cout << score << endl;
    cout << scoreTwo << endl;

    return 0;
}
