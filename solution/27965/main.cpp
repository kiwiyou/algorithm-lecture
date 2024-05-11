#include <iostream>
using namespace std;
int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  int N, K;
  cin >> N >> K;
  long long remainder = 0, ten = 10;
  for (int i = 1; i <= N; ++i) {
    if (i == ten) {
      ten *= 10;
    }
    remainder = (remainder * ten + i) % K;
  }
  cout << remainder;
}
