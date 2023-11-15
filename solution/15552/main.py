def main():
    input = open(0, 'rb').readline
    T = int(input())
    for _ in range(T):
        a, b = map(int, input().split())
        print(a + b)

if __name__ == "__main__":
    main()