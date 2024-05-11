import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        String line;
        while (true) {
            line = stdin.readLine();
            if (line == null) break;
            int n = Integer.parseInt(line);
            int length = 1;
            int remainder = 1 % n;
            while (remainder != 0) {
                remainder = (remainder * 10 + 1) % n;
                length++;
            }
            stdout.append(length).append('\n');
        }
        System.out.println(stdout);
    }
}
