const { readFileSync } = require("fs");
const token = readFileSync(0, { encoding: "ascii" })
  .split(/\s+/)
  [Symbol.iterator]();
const line = [];

const T = +token.next().value;
for (let i = 0; i < T; ++i) {
  const n = +token.next().value;
  let ok = is_over(n);
  for (let i = 2; i * i <= n; ++i) {
    if (n % i === 0) {
      if (is_over(i) || is_over(n / i)) {
        ok = false;
        break;
      }
    }
  }
  if (ok) {
    line.push("Good Bye");
  } else {
    line.push("BOJ 2022");
  }
}
console.log(line.join("\n"));

function is_over(n) {
  let sum = 1;
  for (let i = 2; i * i <= n; ++i) {
    if (n % i === 0) {
      sum += i;
      const j = n / i;
      if (i !== j) {
        sum += j;
      }
    }
  }
  return sum > n;
}
