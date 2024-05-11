def main():
    input = open(0, "rb").readline
    while True:
        try:
            n = int(input())
            length = 1
            remainder = 1 % n
            while remainder != 0:
                remainder = (remainder * 10 + 1) % n
                length += 1
            print(length)
        except ValueError:
            break


if __name__ == "__main__":
    main()

