fn main() {
    use std::io::*;
    let stdin = read_to_string(stdin().lock()).unwrap();
    let mut tokens = stdin.split_whitespace();
    let mut next = || tokens.next().unwrap();
    let n = next().parse::<usize>().unwrap();
    let mut first_win = vec![false];
    for i in 1..=n {
        let mut is_win = true;
        if first_win[i - 1] {
            is_win = false;
        }
        if i >= 3 && first_win[i - 3] {
            is_win = false;
        }
        first_win.push(is_win);
    }
    println!("{}", if first_win[n] { "SK" } else { "CY" });
}
