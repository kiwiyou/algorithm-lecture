#include <iostream>
using namespace std;
int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  int n;
  while (cin >> n) {
    int length = 1;
    int remainder = 1 % n;
    while (remainder != 0) {
      remainder = (remainder * 10 + 1) % n;
      length++;
    }
    cout << length << '\n';
  }
}
