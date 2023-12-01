def main():
    input = open(0, "rb").readline
    N = int(input())
    first_win = [False]
    for _ in range(1, N + 1):
        is_win = True
        if first_win[-1]:
            is_win = False
        if len(first_win) >= 3 and first_win[-3]:
            is_win = False
        first_win.append(is_win)
    print("SK" if first_win[N] else "CY")

main()