#include <iostream>
#include <vector>
using namespace std;
int main() {
  cin.tie(nullptr)->sync_with_stdio(false);
  int N;
  cin >> N;
  for (int i = 0; i < 3; ++i) {
    vector<int> min_diff = {0};
    vector<int> prefix_sum = {0};
    int prefix = 0;
    for (int j = 0; j < N; ++j) {
      int ai;
      cin >> ai;
      prefix += ai;
      int optimal = 1 << 30;
      for (int k = 0; k <= j; ++k)
        optimal = min(optimal, prefix - prefix_sum[k] - min_diff[k]);
      min_diff.push_back(optimal);
      prefix_sum.push_back(prefix);
    }
    int last = min_diff.back();
    if (last < 0)
      cout << "A";
    else if (last > 0)
      cout << "B";
    else
      cout << "D";
    cout << '\n';
  }
}