#include <iostream>
using namespace std;
int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);

  int N;
  cin >> N;
  int prev = 2, cur = 3;
  for (int i = 4; prev * cur <= N; ++i) {
    bool is_prime = true;
    for (int j = 2; j * j <= i; ++j) {
      if (i % j == 0) {
        is_prime = false;
        break;
      }
    }
    if (is_prime) {
      prev = cur;
      cur = i;
    }
  }
  cout << prev * cur;
}
