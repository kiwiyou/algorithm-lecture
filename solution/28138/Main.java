import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        String[] line = stdin.readLine().split(" ");
        long N = Long.parseLong(line[0]);
        long R = Long.parseLong(line[1]);
        long factorize = N - R;
        long answer = 0;
        for (long i = 1; i * i <= factorize; ++i) {
            if (factorize % i == 0) {
                if (i > R) {
                    answer += i;
                }
                long j = factorize / i;
                if (j != i && j > R) {
                    answer += j;
                }
            }
        }
        stdout.append(answer);
        System.out.println(stdout);
    }
}
