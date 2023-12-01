def main():
    input = open(0, "rb").readline
    N = int(input())
    for _ in range(3):
        min_diff = [0]
        prefix_sum = [0]
        prefix = 0
        for ai in map(int, input().split()):
            prefix += ai
            optimal = 1 << 30
            for d, s in zip(min_diff, prefix_sum):
                optimal = min(optimal, prefix - s - d)
            min_diff.append(optimal)
            prefix_sum.append(prefix)
        if min_diff[-1] < 0:
            print("A")
        elif min_diff[-1] > 0:
            print("B")
        else:
            print("D")


main()
