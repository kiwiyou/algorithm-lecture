fn main() {
    use std::io::*;
    let stdin = read_to_string(stdin().lock()).unwrap();
    let mut tokens = stdin.split_whitespace();
    let mut next = || tokens.next().unwrap();
    let n = next().parse::<usize>().unwrap();
    let mut q = vec![];
    for _ in 0..n {
        let qi = next().parse::<usize>().unwrap();
        q.push(qi);
    }
    let mut column = vec![false; n];
    let mut slash = vec![false; 2 * n - 1];
    let mut backslash = vec![false; 2 * n - 1];
    for r in 0..n {
        if q[r] != 0 {
            let c = q[r] - 1;
            (column[c], slash[c + r], backslash[c + n - r - 1]) = (true, true, true);
        }
    }
    if !find_queen(&mut column, &mut slash, &mut backslash, &mut q, 0) {
        println!("-1");
    }
}

fn find_queen(
    column: &mut [bool],
    slash: &mut [bool],
    backslash: &mut [bool],
    a: &mut [usize],
    r: usize,
) -> bool {
    let n = a.len();
    if r == n {
        for &ai in a.iter() {
            print!("{ai} ");
        }
        true
    } else if a[r] != 0 {
        find_queen(column, slash, backslash, a, r + 1)
    } else {
        for c in 0..n {
            if !column[c] && !slash[c + r] && !backslash[c + n - r - 1] {
                (column[c], slash[c + r], backslash[c + n - r - 1]) = (true, true, true);
                a[r] = c + 1;
                if find_queen(column, slash, backslash, a, r + 1) {
                    return true;
                }
                a[r] = 0;
                (column[c], slash[c + r], backslash[c + n - r - 1]) = (false, false, false);
            }
        }
        false
    }
}
