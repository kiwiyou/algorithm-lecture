#include <iostream>
#include <vector>
using namespace std;
bool find_queen(vector<bool> &column, vector<bool> &slash,
                vector<bool> &backslash, vector<int> &A, int r) {
  int N = A.size();
  if (r == N) {
    for (auto &Ai : A)
      cout << Ai << ' ';
    return true;
  } else if (A[r] != 0) {
    return find_queen(column, slash, backslash, A, r + 1);
  } else {
    for (int c = 0; c < N; ++c) {
      if (!column[c] && !slash[c + r] && !backslash[c + N - r - 1]) {
        column[c] = slash[c + r] = backslash[c + N - r - 1] = true;
        A[r] = c + 1;
        if (find_queen(column, slash, backslash, A, r + 1))
          return true;
        A[r] = 0;
        column[c] = slash[c + r] = backslash[c + N - r - 1] = false;
      }
    }
    return false;
  }
}

int main() {
  cin.tie(nullptr)->sync_with_stdio(false);
  int N;
  cin >> N;
  vector<int> Q(N);
  for (auto &Qi : Q)
    cin >> Qi;
  vector<bool> column(N);
  vector<bool> slash(2 * N - 1);
  vector<bool> backslash(2 * N - 1);
  for (int r = 0; r < N; ++r) {
    if (Q[r] != 0) {
      int c = Q[r] - 1;
      column[c] = slash[c + r] = backslash[c + N - r - 1] = true;
    }
  }
  if (!find_queen(column, slash, backslash, Q, 0))
    cout << -1;
}