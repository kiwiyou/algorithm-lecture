def main():
    import itertools as it

    M, N = map(int, input().split())
    c = memoryview(bytearray([1]) * 499999)
    f = memoryview(bytearray(499999))
    for i in range(499):
        if c[i]:
            c[2 * i * (i + 3) + 3 :: 2 * i + 3] = f[2 * i * (i + 3) + 3 :: 2 * i + 3]
    if M <= 2 <= N:
        print(2)
        M = 3
    p = (M - 2) // 2
    q = (N - 3) // 2 + 1
    print("\n".join(map(str, it.compress(range(p * 2 + 3, q * 2 + 3, 2), c[p:q]))))


main()
