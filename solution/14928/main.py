def main():
    input = open(0, "rb").readline
    N = input().rstrip()
    remainder = 0
    for c in N:
        remainder = (remainder * 10 + c - ord("0")) % 20000303
    print(remainder)


if __name__ == "__main__":
    main()
