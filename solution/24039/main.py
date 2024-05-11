def main():
    input = open(0, "rb").readline
    N = int(input())
    prev, cur, i = 2, 3, 4
    while prev * cur <= N:
        j = 2
        while j * j <= i:
            if i % j == 0:
                break
            j += 1
        else:
            prev = cur
            cur = i
        i += 1
    print(prev * cur)


if __name__ == "__main__":
    main()
