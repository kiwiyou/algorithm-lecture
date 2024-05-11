#include <iostream>
using namespace std;
int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  long long N, R;
  cin >> N >> R;
  long long factorize = N - R;
  long long sum = 0;
  for (long long i = 1; i * i <= factorize; ++i) {
    if (factorize % i == 0) {
      if (i > R) {
        sum += i;
      }
      long long j = factorize / i;
      if (j != i && j > R) {
        sum += j;
      }
    }
  }
  cout << sum;
}
