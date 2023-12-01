fn main() {
    use std::fmt::Write;
    use std::io::*;
    let stdin = read_to_string(stdin().lock()).unwrap();
    let mut tokens = stdin.split_whitespace();
    let mut next = || tokens.next().unwrap();
    let n = next().parse::<usize>().unwrap();
    let m = next().parse::<usize>().unwrap();
    let mut a = vec![];
    let mut stdout = String::new();
    for _ in 0..n {
        let mut ai = vec![];
        for _ in 0..n {
            let aij = next().parse::<u32>().unwrap();
            ai.push(aij);
        }
        a.push(ai);
    }
    for r in 1..n {
        for c in 0..n {
            a[r][c] += a[r - 1][c];
        }
    }
    for r in 0..n {
        for c in 1..n {
            a[r][c] += a[r][c - 1];
        }
    }
    for _ in 0..m {
        let x1 = next().parse::<usize>().unwrap() - 1;
        let y1 = next().parse::<usize>().unwrap() - 1;
        let x2 = next().parse::<usize>().unwrap() - 1;
        let y2 = next().parse::<usize>().unwrap() - 1;
        let mut s = a[x2][y2];
        if x1 > 0 && y1 > 0 {
            s += a[x1 - 1][y1 - 1];
        }
        if x1 > 0 {
            s -= a[x1 - 1][y2];
        }
        if y1 > 0 {
            s -= a[x2][y1 - 1];
        }
        writeln!(stdout, "{s}").ok();
    }
    print!("{stdout}");
}
