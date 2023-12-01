#include <iostream>
#include <vector>
using namespace std;
int main() {
  cin.tie(nullptr)->sync_with_stdio(false);
  int N;
  cin >> N;
  vector<bool> first_win = {false};
  for (int i = 1; i <= N; ++i) {
    bool is_win = true;
    if (first_win[i - 1])
      is_win = false;
    if (i >= 3 && first_win[i - 3])
      is_win = false;
    first_win.push_back(is_win);
  }
  if (first_win[N])
    cout << "SK";
  else
    cout << "CY";
}