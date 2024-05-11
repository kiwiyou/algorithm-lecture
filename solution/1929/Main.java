import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        String[] token = stdin.readLine().split(" ");
        int M = Integer.parseInt(token[0]);
        int N = Integer.parseInt(token[1]);
        boolean[] is_not_prime = new boolean[N + 1];
        for (int i = 2; i <= N; ++i) {
            if (!is_not_prime[i]) {
                if (i >= M) {
                    stdout.append(i).append('\n');
                }
                for (int j = 2 * i; j <= N; j += i) {
                    is_not_prime[j] = true;
                }
            }
        }
        System.out.println(stdout);
    }
}
