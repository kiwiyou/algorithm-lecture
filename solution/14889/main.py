def find_min_diff(start, link, i, S):
    half = len(S) // 2 
    if len(start) == half and len(link) == half:
        diff = 0
        for a in start:
            for b in start:
                diff += S[a][b]
        for a in link:
            for b in link:
                diff -= S[a][b]
        return abs(diff)
    ans = 1 << 30
    if len(start) < half:
        start.append(i)
        ans = min(ans, find_min_diff(start, link, i + 1, S))
        start.pop()
    if len(link) < half:
        link.append(i)
        ans = min(ans, find_min_diff(start, link, i + 1, S))
        link.pop()
    return ans

def main():
    input = open(0, 'rb').readline
    N = int(input())
    S = [[*map(int, input().split())] for _ in range(N)]
    print(find_min_diff([], [], 0, S))

main()