import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        int N = Integer.parseInt(stdin.readLine());
        int prev = 2, cur = 3;
        for (int i = 4; prev * cur <= N; ++i) {
            boolean is_prime = true;
            for (int j = 2; j * j <= i; ++j) {
                if (i % j == 0) {
                    is_prime = false;
                    break;
                }
            }
            if (is_prime) {
                prev = cur;
                cur = i;
            }
        }
        stdout.append(prev * cur);
        System.out.println(stdout);
    }
}
