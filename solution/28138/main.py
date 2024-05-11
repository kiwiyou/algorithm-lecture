def main():
    input = open(0, "rb").readline
    N, R = map(int, input().split())
    factorize = N - R
    answer = 0
    i = 1
    while i * i <= factorize:
        if factorize % i == 0:
            if i > R:
                answer += i
            j = factorize // i
            if j != i and j > R:
                answer += j
        i += 1
    print(answer)


if __name__ == "__main__":
    main()
