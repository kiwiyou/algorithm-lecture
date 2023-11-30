#include <iostream>
#include <vector>
using namespace std;

void print_seq(vector<bool> &is_selected, vector<int> &order, int N, int M) {
  if (M == 0) {
    for (auto &v : order)
      cout << v << ' ';
    cout << '\n';
  } else {
    for (int i = 0; i < N; i++)
      if (!is_selected[i]) {
        is_selected[i] = true;
        order.push_back(i + 1);
        print_seq(is_selected, order, N, M - 1);
        order.pop_back();
        is_selected[i] = false;
      }
  }
}

int main() {
  cin.tie(nullptr)->sync_with_stdio(false);
  int N, M;
  cin >> N >> M;
  vector<bool> is_selected(N);
  vector<int> order;
  print_seq(is_selected, order, N, M);
}