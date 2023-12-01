#include <iostream>
#include <vector>
using namespace std;
int main() {
  cin.tie(nullptr)->sync_with_stdio(false);
  int N, M;
  cin >> N >> M;
  vector<vector<int>> A(N, vector<int>(N));
  for (auto &Ai : A)
    for (auto &Aij : Ai)
      cin >> Aij;
  for (int r = 1; r < N; ++r)
    for (int c = 0; c < N; ++c)
      A[r][c] += A[r - 1][c];
  for (int r = 0; r < N; ++r)
    for (int c = 1; c < N; ++c)
      A[r][c] += A[r][c - 1];
  for (int i = 0; i < M; ++i) {
    int x1, y1, x2, y2;
    cin >> x1 >> y1 >> x2 >> y2, x1--, y1--, x2--, y2--;
    int s = A[x2][y2];
    if (x1 > 0)
      s -= A[x1 - 1][y2];
    if (y1 > 0)
      s -= A[x2][y1 - 1];
    if (x1 > 0 && y1 > 0)
      s += A[x1 - 1][y1 - 1];
    cout << s << '\n';
  }
}