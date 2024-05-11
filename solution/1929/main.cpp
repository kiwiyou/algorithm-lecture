#include <iostream>
#include <vector>
using namespace std;
int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);

  int M, N;
  cin >> M >> N;

  vector<bool> is_prime(N + 1, true);
  for (int i = 2; i <= N; ++i) {
    if (is_prime[i]) {
      if (i >= M) {
        cout << i << '\n';
      }
      for (int j = 2 * i; j <= N; j += i) {
        is_prime[j] = false;
      }
    }
  }
}
