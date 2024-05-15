import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        int T = Integer.parseInt(stdin.readLine());
        for (int i = 0; i < T; ++i) {
            int n = Integer.parseInt(stdin.readLine());
            boolean ok = Main.isOver(n);
            for (int j = 2; j * j <= n; ++j) {
                if (n % j == 0) {
                    if (Main.isOver(j) || Main.isOver(n / j)) {
                        ok = false;
                        break;
                    }
                }
            }
            if (ok) {
                stdout.append("Good Bye\n");
            } else {
                stdout.append("BOJ 2022\n");
            }
        }
        System.out.println(stdout);
    }
    private static boolean isOver(int n) {
        int sum = 1;
        for (int i = 2; i * i <= n; ++i) {
            if (n % i == 0) {
                sum += i;
                int j = n / i;
                if (i != j) {
                    sum += j;
                }
            }
        }
        return sum > n;
    }
}
