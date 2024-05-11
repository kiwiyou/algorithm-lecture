def main():
    input = open(0, "rb").readline
    T = int(input())
    for i in range(T):
        P, Q = map(int, input().split())
        prev = 1
        cur = 0
        for _ in range(P):
            prev, cur = cur, (prev + cur) % Q
        print(f"Case #{i + 1}: {cur}")


if __name__ == "__main__":
    main()
