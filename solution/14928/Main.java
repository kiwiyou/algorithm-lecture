import java.io.*;

public class Main {
    static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in), 1048576);
    static StringBuilder stdout = new StringBuilder();
    public static void main(String[] args) throws Exception {
        String N = stdin.readLine();
        int remainder = 0;
        for (char c : N.toCharArray()) {
            remainder = (remainder * 10 + (int) c - (int) '0') % 20000303;
        }
        stdout.append(remainder);
        System.out.println(stdout);
    }
}
