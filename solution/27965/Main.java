import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        String[] line = stdin.readLine().split(" ");
        long N = Integer.parseInt(line[0]);
        int K = Integer.parseInt(line[1]);
        long remainder = 0, ten = 10;
        for (long i = 1; i <= N; ++i) {
            if (i == ten) {
                ten *= 10;
            }
            remainder = (remainder * ten + i) % K;
        }
        stdout.append(remainder);
        System.out.println(stdout);
    }
}
