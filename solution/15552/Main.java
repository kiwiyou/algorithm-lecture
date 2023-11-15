import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        int T = Integer.parseInt(stdin.readLine());
        for (int i = 0; i < T; ++i) {
            String[] token = stdin.readLine().split(" ");
            int a = Integer.parseInt(token[0]);
            int b = Integer.parseInt(token[1]);
            stdout.append(a + b).append('\n');
        }
        System.out.println(stdout);
    }
}