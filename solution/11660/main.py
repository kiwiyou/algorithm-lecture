def main():
    input = open(0, "rb").readline
    N, M = map(int, input().split())
    A = [[*map(int, input().split())] for _ in range(N)]
    for r in range(1, N):
        for c in range(N):
            A[r][c] += A[r - 1][c]
    for r in range(N):
        for c in range(1, N):
            A[r][c] += A[r][c - 1]
    for _ in range(M):
        x1, y1, x2, y2 = map(int, input().split())
        x1 -= 2
        y1 -= 2
        x2 -= 1
        y2 -= 1
        s = A[x2][y2]
        if x1 >= 0:
            s -= A[x1][y2]
        if y1 >= 0:
            s -= A[x2][y1]
        if x1 >= 0 and y1 >= 0:
            s += A[x1][y1]
        print(s)


main()
