def print_seq(is_selected, order, N, M):
    if M == 0:
        print(*order)
    else:
        for i in range(N):
            if not is_selected[i]:
                is_selected[i] = True
                order.append(i + 1)
                print_seq(is_selected, order, N, M - 1)
                order.pop()
                is_selected[i] = False

def main():
    N, M = map(int, input().split())
    print_seq([False] * N, [], N, M)

main()