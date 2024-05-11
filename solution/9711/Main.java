import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        int T = Integer.parseInt(stdin.readLine());
        for (int i = 0; i < T; ++i) {
            String[] token = stdin.readLine().split(" ");
            int P = Integer.parseInt(token[0]);
            long Q = Long.parseLong(token[1]);
            long prev = 1, cur = 0;
            for (int j = 0; j < P; ++j) {
                long next = (prev + cur) % Q;
                prev = cur;
                cur = next;
            }
            stdout.append("Case #").append(i + 1).append(": ").append(cur).append('\n');
        }
        System.out.println(stdout);
    }
}
