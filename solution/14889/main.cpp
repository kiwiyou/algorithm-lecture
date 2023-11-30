#include <iostream>
#include <vector>
using namespace std;
int find_min_diff(vector<int> &start, vector<int> &link, int i,
                  vector<vector<int>> &S) {
  int half = S.size() / 2;
  if (start.size() == half && link.size() == half) {
    int diff = 0;
    for (auto &a : start)
      for (auto &b : start)
        diff += S[a][b];
    for (auto &a : link)
      for (auto &b : link)
        diff -= S[a][b];
    return abs(diff);
  }
  int ans = 1 << 30;
  if (start.size() < half) {
    start.push_back(i);
    ans = min(ans, find_min_diff(start, link, i + 1, S));
    start.pop_back();
  }
  if (link.size() < half) {
    link.push_back(i);
    ans = min(ans, find_min_diff(start, link, i + 1, S));
    link.pop_back();
  }
  return ans;
}

int main() {
  cin.tie(nullptr)->sync_with_stdio(false);
  int N;
  cin >> N;
  vector<vector<int>> S(N, vector<int>(N));
  for (auto &Si : S)
    for (auto &Sij : Si)
      cin >> Sij;
  vector<int> start, link;
  cout << find_min_diff(start, link, 0, S);
}