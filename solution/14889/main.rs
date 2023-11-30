fn main() {
    use std::io::*;
    let stdin = read_to_string(stdin().lock()).unwrap();
    let mut tokens = stdin.split_whitespace();
    let mut next = || tokens.next().unwrap();
    let n = next().parse::<usize>().unwrap();
    let mut s = vec![];
    for _ in 0..n {
        let mut si = vec![];
        for _ in 0..n {
            let sij = next().parse::<i32>().unwrap();
            si.push(sij);
        }
        s.push(si);
    }
    println!("{}", find_min_diff(&mut vec![], &mut vec![], 0, &s));
}

fn find_min_diff(start: &mut Vec<usize>, link: &mut Vec<usize>, i: usize, S: &[Vec<i32>]) -> i32 {
    let half = S.len() / 2;
    if start.len() == half && link.len() == half {
        let mut diff = 0;
        for &a in start.iter() {
            for &b in start.iter() {
                diff += S[a][b];
            }
        }
        for &a in link.iter() {
            for &b in link.iter() {
                diff -= S[a][b];
            }
        }
        return diff.abs();
    }
    let mut ans = i32::MAX;
    if start.len() < half {
        start.push(i);
        ans = ans.min(find_min_diff(start, link, i + 1, S));
        start.pop();
    }
    if link.len() < half {
        link.push(i);
        ans = ans.min(find_min_diff(start, link, i + 1, S));
        link.pop();
    }
    ans
}
