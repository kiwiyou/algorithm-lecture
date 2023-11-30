def find_queen(column, slash, backslash, A, R):
    if R == len(A):
        print(*A)
        return True
    elif A[R] != 0:
        return find_queen(column, slash, backslash, A, R + 1)
    else:
        for C in range(len(A)):
            if not column[C] and not slash[C + R] and not backslash[C - R]:
                column[C] = slash[C + R] = backslash[C - R] = True
                A[R] = C + 1
                if find_queen(column, slash, backslash, A, R + 1):
                    return True
                A[R] = 0
                column[C] = slash[C + R] = backslash[C - R] = False
        return False

def main():
    N = int(input())
    Q = [*map(int, input().split())]
    column = [False] * N
    slash = [False] * (2 * N - 1)
    backslash = [False] * (2 * N - 1)
    for R in range(N):
        if Q[R] != 0:
            C = Q[R] - 1
            column[C] = slash[C + R] = backslash[C - R] = True
    if not find_queen(column, slash, backslash, Q, 0):
        print(-1)

main()