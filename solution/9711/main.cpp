#include <iostream>
using namespace std;
int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);

  int T;
  cin >> T;

  for (int i = 0; i < T; ++i) {
    int P, Q;
    cin >> P >> Q;
    long long prev = 1, cur = 0;
    for (int j = 0; j < P; ++j) {
      long long next = (prev + cur) % Q;
      prev = cur;
      cur = next;
    }
    cout << "Case #" << i + 1 << ": " << cur << "\n";
  }
}
