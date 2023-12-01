fn main() {
    use std::io::*;
    let stdin = read_to_string(stdin().lock()).unwrap();
    let mut tokens = stdin.split_whitespace();
    let mut next = || tokens.next().unwrap();
    let n = next().parse::<usize>().unwrap();
    for _ in 0..3 {
        let mut min_diff = vec![0];
        let mut prefix_sum = vec![0];
        let mut prefix = 0;
        for _ in 0..n {
            let ai = next().parse::<i32>().unwrap();
            prefix += ai;
            let mut optimal = i32::MAX;
            for (&d, &s) in min_diff.iter().zip(prefix_sum.iter()) {
                optimal = optimal.min(prefix - s - d);
            }
            min_diff.push(optimal);
            prefix_sum.push(prefix);
        }
        let winner = match *min_diff.last().unwrap() {
            ..=-1 => 'A',
            1.. => 'B',
            0 => 'D',
        };
        println!("{winner}");
    }
}
