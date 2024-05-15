#include <iostream>
using namespace std;

bool is_over(int n) {
  int sum = 1;
  for (int i = 2; i * i <= n; ++i) {
    if (n % i == 0) {
      sum += i;
      int j = n / i;
      if (i != j) {
        sum += j;
      }
    }
  }
  return sum > n;
}

int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);

  int T;
  cin >> T;

  for (int i = 0; i < T; ++i) {
    int n;
    cin >> n;
    bool ok = is_over(n);
    for (int i = 2; i * i <= n; ++i) {
      if (n % i == 0) {
        if (is_over(i) || is_over(n / i)) {
          ok = false;
          break;
        }
      }
    }
    if (ok) {
      cout << "Good Bye\n";
    } else {
      cout << "BOJ 2022\n";
    }
  }
}
