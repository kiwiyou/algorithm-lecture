fn main() {
    use std::io::*;
    let stdin = read_to_string(stdin().lock()).unwrap();
    let mut tokens = stdin.split_whitespace();
    let mut next = || tokens.next().unwrap();
    let mut stdout = String::new();
    let n = next().parse::<usize>().unwrap();
    let m = next().parse::<usize>().unwrap();
    print_seq(&mut stdout, &mut vec![false; n], &mut vec![], n, m);
    print!("{stdout}");
}

fn print_seq(
    stdout: &mut String,
    is_selected: &mut [bool],
    order: &mut Vec<usize>,
    n: usize,
    m: usize,
) {
    use std::fmt::*;
    if m == 0 {
        for &v in order.iter() {
            write!(stdout, "{v} ").ok();
        }
        writeln!(stdout).ok();
    } else {
        for i in 0..n {
            if !is_selected[i] {
                is_selected[i] = true;
                order.push(i + 1);
                print_seq(stdout, is_selected, order, n, m - 1);
                order.pop();
                is_selected[i] = false;
            }
        }
    }
}
