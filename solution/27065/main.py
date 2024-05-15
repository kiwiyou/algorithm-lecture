def is_over(n):
    s = 1
    i = 2
    while i * i <= n:
        if n % i == 0:
            s += i
            j = n // i
            if i != j:
                s += j
        i += 1
    return s > n


def main():
    input = open(0, "rb").readline
    T = int(input())
    for _ in range(T):
        n = int(input())
        ok = is_over(n)
        i = 2
        while i * i <= n:
            if n % i == 0:
                if is_over(i) or is_over(n // i):
                    ok = False
                    break
            i += 1
        if ok:
            print("Good Bye")
        else:
            print("BOJ 2022")


if __name__ == "__main__":
    main()
