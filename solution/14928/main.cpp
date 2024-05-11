#include <iostream>
#include <string>
using namespace std;
int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);

  string N;
  cin >> N;
  int remainder = 0;
  for (auto c : N) {
    remainder = (remainder * 10 + c - '0') % 20000303;
  }
  cout << remainder;
}
