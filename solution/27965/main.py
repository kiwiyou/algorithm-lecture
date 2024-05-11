def main():
    input = open(0, "rb").readline
    N, K = map(int, input().split())
    remainder = 0
    ten = 10
    for i in range(1, N + 1):
        if i == ten:
            ten *= 10
        remainder = (remainder * ten + i) % K
    print(remainder)


if __name__ == "__main__":
    main()
